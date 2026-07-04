import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mms_app/models/heart.dart';
import 'package:mms_app/models/sleep.dart';
import 'package:mms_app/models/steps.dart';
import 'package:mms_app/utils/impact.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DataProvider extends ChangeNotifier {
  int stepsTotal = 0;
  double sleepHours = 0.0;
  double energy = 0.0;
  int currentBattery = 0;
  double _stepGoal = 10000.0;
  final double _sleepGoal = 8.0;
  double punteggio = 0;
  int punteggioFinale = 0;
  final Impact impact = Impact();
  List<Sleep> sleepRecords = [];
  double HRToday = 60.0; 
  double meanHR = 0.0; 
  int count = 0;
  double std = 0.0;
  List<RHeartRate> bpmList = [];
  double penalty = 0.0;
  double PointsHR = 0.0;
  double PointsSleep = 0.0;




  DataProvider() {
    _initData();
  }

Future<void> _initData() async {
    final prefs = await SharedPreferences.getInstance();
    _stepGoal = (prefs.getInt('StepsAim') ?? 10000).toDouble();
    await getStepsTotal();
    await requestSleepData();
    await requestHeartRateData();
    await requestHeartRateDataRange();
    await calculateStdDev(bpmList, meanHR);
    await calculatePenalty(HRToday, meanHR, std);
    await _calculateEnergy(penalty, punteggioFinale);
    await _calculatePile(energy);

  }

Future<int> _calculatePile(double currentEnergy) async {
    
    int currentPile;

    if (currentEnergy > 0.9) {
      currentPile = 10;
    } else if (currentEnergy < 0.15) {
      currentPile = 1;
    } else {
      currentPile = (currentEnergy*10).round();
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

    //final day = '2024-09-18';
    final ieri = DateTime.now().subtract(Duration(days: 1));
    final day = DateFormat('yyyy-MM-dd').format(ieri); 
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

Future<void> _calculateEnergy(double penalty, int punteggioFinale) async {
    PointsHR = 50 - penalty;
    PointsSleep = punteggioFinale / 2;
    energy = (PointsHR + PointsSleep)/100;
    // Formula riadattata usando sleepHours calcolato dall'API

    notifyListeners();
  }

void saveBattery(int battery) {
    currentBattery = battery;
    notifyListeners();
  }

 Future<int> sleepQuality(int age) async {

    if (sleepRecords.isEmpty) {
      print('Nessun record di sonno disponibile per il calcolo della qualità del sonno.');
      return 0; // O un valore di default appropriato
    }

    double punteggioCalcolato = 0.0;

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
        punteggioCalcolato += 1;
      } if (minutesToFallAsleep >60) {
        punteggioCalcolato += 2;
      } else {
        punteggioCalcolato += 0;
      }
      
  } else {
    if (minutesToFallAsleep > 30) {
      punteggioCalcolato += 1;
    } if (minutesToFallAsleep >45) {
      punteggioCalcolato += 2;
    } else {
      punteggioCalcolato += 0;
    }
  }
  int minutesAwake = sleep.minutesAwake;
  //MINUTES AWAKE
  if (subjectCategory == category[0]) {
      if (minutesAwake > 20) {
        punteggioCalcolato += 1;
      } if (minutesAwake >45) {
        punteggioCalcolato += 2;
      } else {
        punteggioCalcolato += 0;
      }
      
  } if (subjectCategory == category[1]) {
    if (minutesAwake > 20) {
      punteggioCalcolato += 1;
    } if (minutesToFallAsleep >50) {
      punteggioCalcolato += 2;
    } else {
      punteggioCalcolato += 0;
    }
  } if (subjectCategory == category[2] || subjectCategory == category[3]) {
    if (minutesAwake > 20) {
      punteggioCalcolato += 1;
    } if (minutesToFallAsleep >40) {
      punteggioCalcolato += 2;
    } else {
      punteggioCalcolato += 0;
    }
  } if (subjectCategory == category[4]) {
    if (minutesAwake > 30) {
      punteggioCalcolato += 1;
    } else {
      punteggioCalcolato += 0;
    }
  }
  int sleepEfficiency = sleep.efficiency;
  //SLEEP EFFICIENCY
  if (subjectCategory == category[2]) {
    if (sleepEfficiency < 85) {
      punteggioCalcolato += 1;
    } if (sleepEfficiency <= 64) {
      punteggioCalcolato += 2;
    } else {
      punteggioCalcolato += 0;
    }
    
    } else {
      if (sleepEfficiency < 85) {
      punteggioCalcolato += 1;
    } if (sleepEfficiency < 75) {
      punteggioCalcolato += 2;
    } else {
      punteggioCalcolato += 0;
    }
    }
    int remSleep = sleep.levels.summary.rem.minutes;
    int percentageRemSleep = (remSleep * 100) ~/ sleep.minutesAsleep;
    //REM SLEEP PERCENTAGE
    if (subjectCategory == category[0]) {
      if (percentageRemSleep <=5) {
        punteggioCalcolato += 2;
      } if (percentageRemSleep >=11) {
        punteggioCalcolato += 1;
    }
  } if (subjectCategory == category[1]) {
      if (percentageRemSleep <=10) {
        punteggioCalcolato += 2;
      } if (percentageRemSleep >=11) {
        punteggioCalcolato += 1;
    }
  } if (subjectCategory == category[2] || subjectCategory == category[3]) {
      if (percentageRemSleep <=40) {
        punteggioCalcolato += 1;
      } if (percentageRemSleep >=41) {
        punteggioCalcolato += 2;
    }
  } if (subjectCategory == category[3]) {
      if (percentageRemSleep >=41) {
        punteggioCalcolato += 2;
      } if (percentageRemSleep >=21 && percentageRemSleep <=30) {
        punteggioCalcolato += 0;
    } else {
      punteggioCalcolato += 1;
    }
  } 
  int lightSleep = sleep.levels.summary.light.minutes;
  int percentageLightSleep = (lightSleep * 100) ~/ sleep.minutesAsleep;
  //Blocco N2
  if (percentageLightSleep >= 81) {
    punteggioCalcolato += 2;
  } else {
    punteggioCalcolato += 1;
  }
  int deepSleep = sleep.levels.summary.deep.minutes;
  int percentageDeepSleep = (deepSleep * 100) ~/ sleep.minutesAsleep;
  //Blocco N3
  if (subjectCategory == category[0]) {
    if (percentageDeepSleep <= 10) {
      punteggioCalcolato += 2;
    } if (percentageDeepSleep >= 20 && percentageDeepSleep <= 25) {
      punteggioCalcolato += 0;
    } else {
      punteggioCalcolato += 1;
    }
  } if (subjectCategory == category[1]) {
    if (percentageDeepSleep <= 5) {
      punteggioCalcolato += 2;
    } if (percentageDeepSleep >= 20 && percentageDeepSleep <= 25) {
      punteggioCalcolato += 0;
    } else {
      punteggioCalcolato += 1;
    }
  } if (subjectCategory == category[2]) {
    if (percentageDeepSleep <= 5) {
      punteggioCalcolato += 2;
    } else {
      punteggioCalcolato += 1;
    }
  } if (subjectCategory == category[3]) {
    if (percentageDeepSleep <= 5) {
      punteggioCalcolato += 2;
    } if (percentageDeepSleep >= 16 && percentageDeepSleep <= 20) {
      punteggioCalcolato += 0;
    } else {
      punteggioCalcolato += 1;
    }
  } if (subjectCategory == category[4]) {
    punteggioCalcolato +=1;
  }
  int duration = sleep.minutesAsleep;

  //DURATION
  if (subjectCategory == category[0]) {
    if (duration>= 540 && duration <= 660) {
      punteggioCalcolato += 0;
    } if (duration>= 420 && duration < 540 || duration> 660 && duration <= 720) {
      punteggioCalcolato += 1;
    } else {
      punteggioCalcolato += 2;
    }
  } if (subjectCategory == category[1]) {
    if (duration>= 480 && duration <= 600) {
      punteggioCalcolato += 0;
    } if (duration>= 420 && duration < 480 || duration> 600 && duration <= 660) {
      punteggioCalcolato += 1;
    } else {
      punteggioCalcolato += 2;
    }
  } if (subjectCategory == category[2]) {
    if (duration>= 420 && duration <= 540) {
      punteggioCalcolato += 0;
    } if (duration>= 360 && duration < 420 || duration> 540 && duration <= 660) {
      punteggioCalcolato += 1;
    } else {
      punteggioCalcolato += 2;
    }
  } if (subjectCategory == category[3]) {
    if (duration>= 420 && duration <= 540) {
      punteggioCalcolato += 0;
    } if (duration>= 360 && duration < 420 || duration> 540 && duration <= 600) {
      punteggioCalcolato += 1;
    } else {
      punteggioCalcolato += 2;
    }
  } if (subjectCategory == category[4]) {
    if (duration>= 420 && duration <= 480) {
      punteggioCalcolato += 0;
    } if (duration>= 300 && duration < 420 || duration> 480 && duration <= 540) {
      punteggioCalcolato += 1;
    } else {
      punteggioCalcolato += 2;
    }
  } 
  punteggio = (punteggioCalcolato/14)*100;
  punteggioFinale = (100-punteggio).round();

  notifyListeners();
  return punteggioFinale;

  }

  Future<double> requestHeartRateData() async {
    //Initialize the result
    RHeartRate? result;

    //Get the stored access token (Note that this code does not work if the tokens are null)
    final sp = await SharedPreferences.getInstance();
    var access = sp.getString('access');

    //If access token is expired, refresh it
    if(JwtDecoder.isExpired(access!)){
      await impact.refreshTokens();
      access = sp.getString('access');
    }//if

    //Create the (representative) request
    final ieri = DateTime.now().subtract(Duration(days: 1));
    final day = DateFormat('yyyy-MM-dd').format(ieri);
    final url = '${Impact.baseUrl}${Impact.heartRateEndpoint}${Impact.patientUsername}/day/$day/';
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

    //Get the response
    print('Calling: $url');
    final response = await http.get(Uri.parse(url), headers: headers);
    print('Response: ${response.body}');
    
    //if OK parse the response, otherwise return null
    if (response.statusCode == 200) {
  try {
    final decodedResponse = jsonDecode(response.body);
    result = RHeartRate.fromJson(decodedResponse['data']['date'], decodedResponse['data']['data']);
    HRToday = result.value;
    print('Il valore del battito è: $HRToday');
  } catch (e) {
    // Se c'è un errore di parsing, lo stampa qui nel terminale SENZA frizzare l'app!
    print('Errore durante il parsing del JSON: $e');
    HRToday = 0.0; // Valore di fallback
  }
}
    else{
      result = null;
    }//else
    notifyListeners();
    return HRToday;

  } //_requestData
  
  Future<double> requestHeartRateDataRange() async {
    
    double sum = 0.0;
  
    final sp = await SharedPreferences.getInstance();
    var access = sp.getString('access');

    if(JwtDecoder.isExpired(access!)){
      await impact.refreshTokens();
      access = sp.getString('access');
    }

    // Date perfette per il tuo database
    final startDate = '2024-05-04';
    final endDate = '2024-05-10'; 
    
    final url = '${Impact.baseUrl}${Impact.heartRateEndpoint}${Impact.patientUsername}/daterange/start_date/$startDate/end_date/$endDate/';
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        
        // 'data' è la lista dei giorni (ce ne sono 7 nel tuo JSON)
        final List<dynamic> listaGiorni = decodedResponse['data'];

        for (var i = 0; i < listaGiorni.length; i++) {
          final giornoCorrente = listaGiorni[i];
          
          if (giornoCorrente != null && giornoCorrente['data'] != null) {
            final String dataDelGiorno = giornoCorrente['date'];
            
            // ESTRAZIONE DIRETTA: 'data' interno è una mappa {}, quindi lo leggiamo direttamente!
            final Map<String, dynamic> heartData = giornoCorrente['data'];
            
            // Creiamo l'oggetto usando il tuo costruttore stabile
            final nuovoBattito = RHeartRate.fromJson(dataDelGiorno, heartData);
            bpmList.add(nuovoBattito);
            
            sum += nuovoBattito.value;
            count++;
          } 
        }
        
        // Calcolo della media finale
        meanHR = count > 0 ? sum / count : 0.0;
        print('Media calcolata con successo su $count giorni!');
        
      } else {
        throw Exception('Status ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      rethrow; 
    }
    notifyListeners();
    return meanHR;
}

Future<double> calculateStdDev(List<RHeartRate> bpsList, double mean) async{
  // Se non ci sono abbastanza dati per calcolare la deviazione campionaria, restituisce 0.0
  if (bpsList.length <= 1) return 0.0;

  double sommaScartiQuadrati = 0.0;

  // 1. Calcola la somma degli scarti al quadrato: (x - media)^2
  for (var i = 0; i < bpsList.length; i++) {
    double scarto = bpsList[i].value - mean;
    sommaScartiQuadrati += scarto * scarto;
  }

  // 2. Applica la formula della deviazione standard campionaria (diviso N - 1)
  double variance = sommaScartiQuadrati / (bpsList.length - 1);
  std = math.sqrt(variance);
  notifyListeners();
  return std;
}

Future<double> calculatePenalty(double HRtoday, double mean, double std) async {
  // Controllo di sicurezza: se la deviazione standard è zero, 
  // evitiamo la divisione per zero restituendo una penalità nulla (0.0)
  if (std == 0.0) {
    print('Attenzione: Deviazione standard pari a 0. Di default la penalità è 0.0');
    return 0.0;
  }

  // Applicazione della formula: ((HRtoday - media) / std) / 2
  penalty = ((HRtoday - mean) / std) / 2;
  penalty = penalty*50;

  print('Coefficiente di penalità calcolato: $penalty');
  notifyListeners();
  return penalty;
}


  /*void updateStepGoal(double newGoal) {
    _stepGoal = newGoal;
    _calculateTiredness();
  }*/




}



