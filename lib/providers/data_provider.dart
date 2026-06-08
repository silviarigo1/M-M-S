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
  double _stepGoal = 10000.0;
  final double _sleepGoal = 8.0;

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
    
    // Calcoliamo la stanchezza solo dopo aver ottenuto sia passi che sonno
    _calculateTiredness();
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

    final day = '2024-02-14'; 
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

void _calculateTiredness() {
    if (_stepGoal == 0) _stepGoal = 10000.0; // Evita divisioni per zero
    
    double currentSteps = stepsTotal.toDouble();
    
    // Formula riadattata usando sleepHours calcolato dall'API
    double tirednessFormula = (currentSteps / _stepGoal) * (1 - (sleepHours / _sleepGoal));
    tiredness = tirednessFormula.clamp(0.0, 1.0);
    
    print('Stanchezza calcolata nel Provider: $tiredness (Ore Sonno: $sleepHours)');
    notifyListeners();
  }

  /*void updateStepGoal(double newGoal) {
    _stepGoal = newGoal;
    _calculateTiredness();
  }*/

}