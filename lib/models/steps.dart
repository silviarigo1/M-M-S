// This model is used to store the data of the steps: date/time and value of steps.
import 'package:intl/intl.dart';

class Steps{
  final DateTime time;
  final int value;

  Steps({required this.time, required this.value});

  Steps.fromJson(String date, Map<String, dynamic> json) :
      time = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}'),
      value = int.parse(json["value"]);

  @override
  String toString() {
    return 'Steps(time: $time, value: $value)';
  }//toString
}//Steps