import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mms_app/models/sleep.dart';
import 'package:mms_app/models/steps.dart';
import 'package:mms_app/utils/impact.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DataProvider extends ChangeNotifier {
  int stepsTotal = 0;
  double sleepHours = 0.0;
  double tiredness = 0.0;
  int currentBattery = 0;
  double _stepGoal = 10000.0;
  final double _sleepGoal = 8.0;
  double punteggio = 0;
  final Impact impact = Impact();
  List<Sleep> sleepRecords = [];

  DataProvider() {
    _initData();
  }

Future<void> _initData() async {
    final prefs = await SharedPreferences.getInstance();
    _stepGoal = (prefs.getInt('StepsAim') ?? 10000).toDouble();
    await getStepsTotal();
    await requestSleepData();
    //await impact.requestHeartRateData();
    
    // Calcoliamo la stanchezza solo dopo aver ottenuto sia passi che sonno
    await _calculateTiredness();
    await _calculatePile();
  }

Future<int> _calculatePile() async {
    int currentEnergy = 1 - tiredness.toInt();
    int currentPile;

    if (currentEnergy > 0.9) {
      currentPile = 10;
    } else if (currentEnergy < 0.15) {
      currentPile = 1;
    } else {
      currentPile = (currentEnergy / 0.1).round();
    }

    saveBattery(currentPile);
    return currentPile;
  }

Future<int> getStepsTotal() async {

  try {
    final List<Steps>? stepsList = await impact.requestData();

    if (stepsList != null) {
      for (var step in stepsList) {
          stepsTotal += step.value; 
        }
    }
  } catch (e) {
    print('Errore durante il calcolo dei passi totali: $e');
    return 0;
  }

  print('Total steps calcolati: $stepsTotal');
  notifyListeners();
  return stepsTotal;

}

Future<List<Sleep>?> requestSleepData() async {
  

  try {
    final sp = await SharedPreferences.getInstance();
    var access = sp.getString('access');

    if (access != null && JwtDecoder.isExpired(access)) {
      await Impact().refreshTokens();
      final spAggiornato = await SharedPreferences.getInstance();
      access = spAggiornato.getString('access');
    }

    final day = '2024-09-18'; 
    // ignore: prefer_interpolation_to_compose_strings
    final url = Impact.baseUrl + Impact.sleepEndpoint + Impact.patientUsername + '/day/$day/';
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

    print('Calling Sleep API: $url');
    final response = await http.get(Uri.parse(url), headers: headers);
    
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      
      sleepRecords = [];
      
      final dynamic rawData = decodedResponse['data']['data'];
      
      if (rawData is List) {
        for (var record in rawData) {
          sleepRecords.add(Sleep.fromJson(day, record));
        }
      } else if (rawData is Map<String, dynamic>) {
        sleepRecords.add(Sleep.fromJson(day, rawData));
      }

      if (sleepRecords.isNotEmpty) {
          // Se la tua classe ha il campo minutesAsleep (es. int o double)
          // Sommiamo tutti i minuti se ci sono più sessioni nello stesso giorno
          int totalMinutes = sleepRecords.fold(0, (sum, item) => sum + (item.minutesAsleep).toInt());
          sleepHours = totalMinutes / 60.0;
          await sleepQuality(30); 
        } else {
          sleepHours = 0.0;
        }
    } else {
      print('Errore Server Sonno: Status ${response.statusCode}');
      sleepRecords = [];
      sleepHours = 0.0;
    }
  } catch (e) {
    print('Errore critico durante il parsing dei dati del sonno: $e');
    sleepRecords = [];
    sleepHours = 0.0;
  }
  //_sleepTotal = sleepRecords[0].minutesAsleep; // Aggiorna sleepTotal con i minuti di sonno totali (o un altro campo che preferisci)
  notifyListeners();
  print('Sleep records ottenuti: ${sleepRecords.length}');
  return sleepRecords;
  
}

Future<void> _calculateTiredness() async {
    if (_stepGoal == 0) _stepGoal = 10000.0; // Evita divisioni per zero
    
    double currentSteps = stepsTotal.toDouble();
    
    // Formula riadattata usando sleepHours calcolato dall'API
    double tirednessFormula = (currentSteps / _stepGoal) * (1 - (sleepHours / _sleepGoal));
    tiredness = tirednessFormula.clamp(0.0, 1.0);
    
    print('Stanchezza calcolata nel Provider: $tiredness (Ore Sonno: $sleepHours)');
    notifyListeners();
  }

void saveBattery(int battery) {
    currentBattery = battery;
    notifyListeners();
  }

 Future<double> sleepQuality(int age) async {

    List<String> category = ['kids', 'teenagers', 'young adults', 'adults', 'older adults'];
    String subjectCategory = '';
    if (age <= 13){
      subjectCategory = category[0];
    } if (age > 13 && age <= 17) {
      subjectCategory = category[1];
    } if (age >= 18 && age <= 25) {
      subjectCategory = category[2];
    } if (age >= 26 && age <= 64) {
      subjectCategory = category[3];
    } if (age >= 65) {
      subjectCategory = category[4];
    }
    Sleep sleep = sleepRecords[0];
    int minutesToFallAsleep = sleep.minutesToFallAsleep;
    // MINUTES TO FALL ASLEEP
    if (subjectCategory == category[4]) {
      if (minutesToFallAsleep > 30) {
        punteggio += 1;
      } if (minutesToFallAsleep >60) {
        punteggio += 2;
      } else {
        punteggio += 0;
      }
      
  } else {
    if (minutesToFallAsleep > 30) {
      punteggio += 1;
    } if (minutesToFallAsleep >45) {
      punteggio += 2;
    } else {
      punteggio += 0;
    }
  }
  int minutesAwake = sleep.minutesAwake;
  //MINUTES AWAKE
  if (subjectCategory == category[0]) {
      if (minutesAwake > 20) {
        punteggio += 1;
      } if (minutesAwake >45) {
        punteggio += 2;
      } else {
        punteggio += 0;
      }
      
  } if (subjectCategory == category[1]) {
    if (minutesAwake > 20) {
      punteggio += 1;
    } if (minutesToFallAsleep >50) {
      punteggio += 2;
    } else {
      punteggio += 0;
    }
  } if (subjectCategory == category[2] || subjectCategory == category[3]) {
    if (minutesAwake > 20) {
      punteggio += 1;
    } if (minutesToFallAsleep >40) {
      punteggio += 2;
    } else {
      punteggio += 0;
    }
  } if (subjectCategory == category[4]) {
    if (minutesAwake > 30) {
      punteggio += 1;
    } else {
      punteggio += 0;
    }
  }
  int sleepEfficiency = sleep.efficiency;
  //SLEEP EFFICIENCY
  if (subjectCategory == category[2]) {
    if (sleepEfficiency < 85) {
      punteggio += 1;
    } if (sleepEfficiency <= 64) {
      punteggio += 2;
    } else {
      punteggio += 0;
    }
    
    } else {
      if (sleepEfficiency < 85) {
      punteggio += 1;
    } if (sleepEfficiency < 75) {
      punteggio += 2;
    } else {
      punteggio += 0;
    }
    }
    int RemSleep = sleep.levels.summary.rem.minutes;
    int percentageRemSleep = (RemSleep * 100) ~/ sleep.minutesAsleep;
    //REM SLEEP PERCENTAGE
    if (subjectCategory == category[0]) {
      if (percentageRemSleep <=5) {
        punteggio += 2;
      } if (percentageRemSleep >=11) {
        punteggio += 1;
    }
  } if (subjectCategory == category[1]) {
      if (percentageRemSleep <=10) {
        punteggio += 2;
      } if (percentageRemSleep >=11) {
        punteggio += 1;
    }
  } if (subjectCategory == category[2] && subjectCategory == category[3]) {
      if (percentageRemSleep <=40) {
        punteggio += 1;
      } if (percentageRemSleep >=41) {
        punteggio += 2;
    }
  } if (subjectCategory == category[3]) {
      if (percentageRemSleep >=41) {
        punteggio += 2;
      } if (percentageRemSleep >=21 && percentageRemSleep <=30) {
        punteggio += 0;
    } else {
      punteggio += 1;
    }
  } 
  int lightSleep = sleep.levels.summary.light.minutes;
  int percentageLightSleep = (lightSleep * 100) ~/ sleep.minutesAsleep;
  //Blocco N2
  if (percentageLightSleep >= 81) {
    punteggio += 2;
  } else {
    punteggio += 1;
  }
  int deepSleep = sleep.levels.summary.deep.minutes;
  int percentageDeepSleep = (deepSleep * 100) ~/ sleep.minutesAsleep;
  //Blocco N3
  if (subjectCategory == category[0]) {
    if (percentageDeepSleep <= 10) {
      punteggio += 2;
    } if (percentageDeepSleep >= 20 && percentageDeepSleep <= 25) {
      punteggio += 0;
    } else {
      punteggio += 1;
    }
  } if (subjectCategory == category[1]) {
    if (percentageDeepSleep <= 5) {
      punteggio += 2;
    } if (percentageDeepSleep >= 20 && percentageDeepSleep <= 25) {
      punteggio += 0;
    } else {
      punteggio += 1;
    }
  } if (subjectCategory == category[2]) {
    if (percentageDeepSleep <= 5) {
      punteggio += 2;
    } else {
      punteggio += 1;
    }
  } if (subjectCategory == category[3]) {
    if (percentageDeepSleep <= 5) {
      punteggio += 2;
    } if (percentageDeepSleep >= 16 && percentageDeepSleep <= 20) {
      punteggio += 0;
    } else {
      punteggio += 1;
    }
  } if (subjectCategory == category[4]) {
    punteggio +=1;
  }
  int duration = sleep.minutesAsleep;

  //DURATION
  if (subjectCategory == category[0]) {
    if (duration>= 540 && duration <= 660) {
      punteggio += 0;
    } if (duration>= 420 && duration < 540 || duration> 660 && duration <= 720) {
      punteggio += 1;
    } else {
      punteggio += 2;
    }
  } if (subjectCategory == category[1]) {
    if (duration>= 480 && duration <= 600) {
      punteggio += 0;
    } if (duration>= 420 && duration < 480 || duration> 600 && duration <= 660) {
      punteggio += 1;
    } else {
      punteggio += 2;
    }
  } if (subjectCategory == category[2]) {
    if (duration>= 420 && duration <= 540) {
      punteggio += 0;
    } if (duration>= 360 && duration < 420 || duration> 540 && duration <= 660) {
      punteggio += 1;
    } else {
      punteggio += 2;
    }
  } if (subjectCategory == category[3]) {
    if (duration>= 420 && duration <= 540) {
      punteggio += 0;
    } if (duration>= 360 && duration < 420 || duration> 540 && duration <= 600) {
      punteggio += 1;
    } else {
      punteggio += 2;
    }
  } if (subjectCategory == category[4]) {
    if (duration>= 420 && duration <= 480) {
      punteggio += 0;
    } if (duration>= 300 && duration < 420 || duration> 480 && duration <= 540) {
      punteggio += 1;
    } else {
      punteggio += 2;
    }
  } 
  punteggio = punteggio/14*100;
  punteggio = 100-punteggio;

  notifyListeners();
  return punteggio;

  }


  /*void updateStepGoal(double newGoal) {
    _stepGoal = newGoal;
    _calculateTiredness();
  }*/

}
