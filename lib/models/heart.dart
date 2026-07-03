import 'package:intl/intl.dart';

class RHeartRate {
  final DateTime time;
  final double value;
  final double error; 

  RHeartRate({required this.time, required this.value, required this.error});

  // Costruttore corretto senza double.parse()
  RHeartRate.fromJson(String date, Map<String, dynamic> json) :
      time = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}'),
      // Visto che sono già double nel JSON, facciamo il cast sicuro tramite num
      value = (json["value"] as num).toDouble(),
      error = (json["error"] as num).toDouble();

  @override
  String toString() {
    return 'RHeartRate(time: $time, value: $value, error: $error)';
  }
}