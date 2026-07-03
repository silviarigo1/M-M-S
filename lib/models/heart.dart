import 'package:intl/intl.dart';

class RHeartRate{
  final DateTime time;
  final int value;
  final int error; 

  RHeartRate({required this.time, required this.value, required this.error});

  RHeartRate.fromJson(String date, Map<String, dynamic> json) :
      time = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}'),
      value = int.parse(json["value"]),
      error = int.parse(json["error"]);

  @override
  String toString() {
    return 'RHeartRate(time: $time, value: $value, error: $error)';
  }//toString
}//RHeartRate