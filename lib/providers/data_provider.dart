// This provider is responsible for managing the data related to steps, sleep, heart rate, and energy levels.
// 

import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
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
  double scoreSleep = 0;
  int finalScore = 0;
  final Impact impact = Impact(); // Instance of the Impact class to handle API requests
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
    await _calculateEnergy(penalty, finalScore);
    await _calculatePile(energy);

  }

// This method calculates the current battery level based on the current energy level.
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

// This method calculates the total number of steps taken by the user. 
//It retrieves the data from the Impact API and sums up the values of steps.
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

// This method requests sleep data from the Impact API (for the previous day).
Future<List<Sleep>?> requestSleepData() async {
  try {
    final sp = await SharedPreferences.getInstance();
    var access = sp.getString('access');
    if (access != null && JwtDecoder.isExpired(access)) {
      await Impact().refreshTokens();
      final spAggiornato = await SharedPreferences.getInstance();
      access = spAggiornato.getString('access');
    }

    final ieri = DateTime.now().subtract(Duration(days: 1));
    final day = DateFormat('yyyy-MM-dd').format(ieri); 
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

      // Calculate total sleep hours if records are available
      if (sleepRecords.isNotEmpty) {
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
  
  notifyListeners();
  print('Sleep records ottenuti: ${sleepRecords.length}');
  return sleepRecords;
  
}

// This method calculates the energy level, with 50% coming from heart rate, after applying a penalty, and 50% from sleep quality. 
Future<void> _calculateEnergy(double penalty, int finalScore) async {
    PointsHR = 50 - penalty;
    PointsSleep = finalScore / 2;
    energy = (PointsHR + PointsSleep)/100;
    notifyListeners();
  }

// This method saves the current battery level and notifies the listeners.
void saveBattery(int battery) {
    currentBattery = battery;
    notifyListeners();
  }

// This method calculates the sleep quality score based on various parameters and the user's age (literature-based thresholds).
 Future<int> sleepQuality(int age) async {
    if (sleepRecords.isEmpty) {
      print('No sleep records are available to calculate sleep quality.');
      return 0; 
    }
    double score = 0.0;
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

    // MINUTES TO FALL ASLEEP
    int minutesToFallAsleep = sleep.minutesToFallAsleep;
    if (subjectCategory == category[4]) {
      if (minutesToFallAsleep > 30) {
        score += 1;
      } if (minutesToFallAsleep >60) {
        score += 2;
      } else {
        score += 0;
      }
  } else {
    if (minutesToFallAsleep > 30) {
      score += 1;
    } if (minutesToFallAsleep >45) {
      score += 2;
    } else {
      score += 0;
    }
  }

  //MINUTES AWAKE
  int minutesAwake = sleep.minutesAwake;
  if (subjectCategory == category[0]) {
      if (minutesAwake > 20) {
        score += 1;
      } if (minutesAwake >45) {
        score += 2;
      } else {
        score += 0;
      }
  } if (subjectCategory == category[1]) {
    if (minutesAwake > 20) {
      score += 1;
    } if (minutesToFallAsleep >50) {
      score += 2;
    } else {
      score += 0;
    }
  } if (subjectCategory == category[2] || subjectCategory == category[3]) {
    if (minutesAwake > 20) {
      score += 1;
    } if (minutesToFallAsleep >40) {
      score += 2;
    } else {
      score += 0;
    }
  } if (subjectCategory == category[4]) {
    if (minutesAwake > 30) {
      score += 1;
    } else {
      score += 0;
    }
  }

  //SLEEP EFFICIENCY
  int sleepEfficiency = sleep.efficiency;
  if (subjectCategory == category[2]) {
    if (sleepEfficiency < 85) {
      score += 1;
    } if (sleepEfficiency <= 64) {
      score += 2;
    } else {
      score += 0;
    }
    } else {
      if (sleepEfficiency < 85) {
      score += 1;
    } if (sleepEfficiency < 75) {
      score += 2;
    } else {
      score += 0;
    }
    }

    //REM SLEEP PERCENTAGE
    int remSleep = sleep.levels.summary.rem.minutes;
    int percentageRemSleep = (remSleep * 100) ~/ sleep.minutesAsleep;
    if (subjectCategory == category[0]) {
      if (percentageRemSleep <=5) {
        score += 2;
      } if (percentageRemSleep >=11) {
        score += 1;
    }
  } if (subjectCategory == category[1]) {
      if (percentageRemSleep <=10) {
        score += 2;
      } if (percentageRemSleep >=11) {
        score += 1;
    }
  } if (subjectCategory == category[2] || subjectCategory == category[3]) {
      if (percentageRemSleep <=40) {
        score += 1;
      } if (percentageRemSleep >=41) {
        score += 2;
    }
  } if (subjectCategory == category[3]) {
      if (percentageRemSleep >=41) {
        score += 2;
      } if (percentageRemSleep >=21 && percentageRemSleep <=30) {
        score += 0;
    } else {
      score += 1;
    }
  } 

  // N2 Stage
  int lightSleep = sleep.levels.summary.light.minutes;
  int percentageLightSleep = (lightSleep * 100) ~/ sleep.minutesAsleep;
  if (percentageLightSleep >= 81) {
    score += 2;
  } else {
    score += 1;
  }

  // N3 Stage
  int deepSleep = sleep.levels.summary.deep.minutes;
  int percentageDeepSleep = (deepSleep * 100) ~/ sleep.minutesAsleep;
  if (subjectCategory == category[0]) {
    if (percentageDeepSleep <= 10) {
      score += 2;
    } if (percentageDeepSleep >= 20 && percentageDeepSleep <= 25) {
      score += 0;
    } else {
      score += 1;
    }
  } if (subjectCategory == category[1]) {
    if (percentageDeepSleep <= 5) {
      score += 2;
    } if (percentageDeepSleep >= 20 && percentageDeepSleep <= 25) {
      score += 0;
    } else {
      score += 1;
    }
  } if (subjectCategory == category[2]) {
    if (percentageDeepSleep <= 5) {
      score += 2;
    } else {
      score += 1;
    }
  } if (subjectCategory == category[3]) {
    if (percentageDeepSleep <= 5) {
      score += 2;
    } if (percentageDeepSleep >= 16 && percentageDeepSleep <= 20) {
      score += 0;
    } else {
      score += 1;
    }
  } if (subjectCategory == category[4]) {
    score +=1;
  }

  //DURATION
  int duration = sleep.minutesAsleep;
  if (subjectCategory == category[0]) {
    if (duration>= 540 && duration <= 660) {
      score += 0;
    } if (duration>= 420 && duration < 540 || duration> 660 && duration <= 720) {
      score += 1;
    } else {
      score += 2;
    }
  } if (subjectCategory == category[1]) {
    if (duration>= 480 && duration <= 600) {
      score += 0;
    } if (duration>= 420 && duration < 480 || duration> 600 && duration <= 660) {
      score += 1;
    } else {
      score += 2;
    }
  } if (subjectCategory == category[2]) {
    if (duration>= 420 && duration <= 540) {
      score += 0;
    } if (duration>= 360 && duration < 420 || duration> 540 && duration <= 660) {
      score += 1;
    } else {
      score += 2;
    }
  } if (subjectCategory == category[3]) {
    if (duration>= 420 && duration <= 540) {
      score += 0;
    } if (duration>= 360 && duration < 420 || duration> 540 && duration <= 600) {
      score += 1;
    } else {
      score += 2;
    }
  } if (subjectCategory == category[4]) {
    if (duration>= 420 && duration <= 480) {
      score += 0;
    } if (duration>= 300 && duration < 420 || duration> 480 && duration <= 540) {
      score += 1;
    } else {
      score += 2;
    }
  } 
  scoreSleep = (score/14)*100;
  finalScore = (100-scoreSleep).round();
  notifyListeners();
  return finalScore;
  }

// This method requests heart rate data for the previous day from the Impact API and updates the HRToday variable.
  Future<double> requestHeartRateData() async {
    RHeartRate? result;
    final sp = await SharedPreferences.getInstance();
    var access = sp.getString('access');
    if(JwtDecoder.isExpired(access!)){
      await impact.refreshTokens();
      access = sp.getString('access');
    }

    final ieri = DateTime.now().subtract(Duration(days: 1));
    final day = DateFormat('yyyy-MM-dd').format(ieri);
    final url = '${Impact.baseUrl}${Impact.heartRateEndpoint}${Impact.patientUsername}/day/$day/';
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

    print('Calling: $url');
    final response = await http.get(Uri.parse(url), headers: headers);
    print('Response: ${response.body}');
    
    if (response.statusCode == 200) {
  try {
    final decodedResponse = jsonDecode(response.body);
    result = RHeartRate.fromJson(decodedResponse['data']['date'], decodedResponse['data']['data']);
    HRToday = result.value;
    print('The value of heart rate is: $HRToday');
  } catch (e) {
    
    print('Error while parsing JSON: $e');
    HRToday = 0.0; // Fallback value
  }
}
    else{
      result = null;
    }
    notifyListeners();
    return HRToday;
  } 
  
  // This method requests heart rate data for a specific date range and calculates the mean heart rate.
  Future<double> requestHeartRateDataRange() async {
    double sum = 0.0;
  
    final sp = await SharedPreferences.getInstance();
    var access = sp.getString('access');

    if(JwtDecoder.isExpired(access!)){
      await impact.refreshTokens();
      access = sp.getString('access');
    }

    // Define the date range (7 days)
    final start = DateTime.now().subtract(Duration(days: 2));
    final startDate = DateFormat('yyyy-MM-dd').format(start);
    final end = DateTime.now().subtract(Duration(days: 8));
    final endDate = DateFormat('yyyy-MM-dd').format(end);
    
    final url = '${Impact.baseUrl}${Impact.heartRateEndpoint}${Impact.patientUsername}/daterange/start_date/$startDate/end_date/$endDate/';
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final List<dynamic> listaGiorni = decodedResponse['data'];

        for (var i = 0; i < listaGiorni.length; i++) {
          final giornoCorrente = listaGiorni[i];
          if (giornoCorrente != null && giornoCorrente['data'] != null) {
            final String dataDelGiorno = giornoCorrente['date'];
            final Map<String, dynamic> heartData = giornoCorrente['data'];
            final nuovoBattito = RHeartRate.fromJson(dataDelGiorno, heartData);
            bpmList.add(nuovoBattito);
            sum += nuovoBattito.value;
            count++;
          } 
        }
        
        // Calculate the mean heart rate over the specified range
        meanHR = count > 0 ? sum / count : 0.0;
        print('Mean calculated successfully over $count days!');
        
      } else {
        throw Exception('Status ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      rethrow; 
    }
    notifyListeners();
    return meanHR;
}

// This method calculates the standard deviation of heart rate values over a specified range.
Future<double> calculateStdDev(List<RHeartRate> bpsList, double mean) async{
  if (bpsList.length <= 1) return 0.0;
  double sommaScartiQuadrati = 0.0;

  // 1. Calculate the sum of squared deviations from the mean
  for (var i = 0; i < bpsList.length; i++) {
    double scarto = bpsList[i].value - mean;
    sommaScartiQuadrati += scarto * scarto;
  }

  // 2. Apply the formula for the sample standard deviation (divided by N - 1)
  double variance = sommaScartiQuadrati / (bpsList.length - 1);
  std = math.sqrt(variance);
  notifyListeners();
  return std;
}

// This method calculates a penalty coefficient based on the current heart rate, mean heart rate, and standard deviation.
Future<double> calculatePenalty(double HRtoday, double mean, double std) async {

  if (std == 0.0) {
    print('Warning: Standard deviation is zero. Default penalty is 0.0');
    return 0.0;
  }

  penalty = ((HRtoday - mean) / std) / 2;
  penalty = penalty*50;

  print('Calculated penalty coefficient: $penalty');
  notifyListeners();
  return penalty;
}

}



