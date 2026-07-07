// This is a model class for representing heart rate data. It includes fields for the time of the measurement, the heart rate value, and an error margin. 

import 'package:intl/intl.dart';

class RHeartRate {
  final DateTime time;
  final double value;
  final double error; 

  RHeartRate({required this.time, required this.value, required this.error});

  RHeartRate.fromJson(String date, Map<String, dynamic> json) :
      time = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}'),
      value = (json["value"] as num).toDouble(),
      error = (json["error"] as num).toDouble();

  @override
  String toString() {
    return 'RHeartRate(time: $time, value: $value, error: $error)';
  }
}