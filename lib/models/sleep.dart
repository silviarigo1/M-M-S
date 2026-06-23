import 'package:intl/intl.dart';

// --- CLASSE PRINCIPALE (RADICE) ---
class Sleep {
  final String dateOfSleep;          
  final DateTime startTime;          
  final DateTime endTime;            
  final int duration;                
  final int minutesToFallAsleep;
  final int minutesAsleep;
  final int minutesAwake;
  final int minutesAfterWakeup;
  final int efficiency;              
  final String logType;              
  final bool mainSleep;
  final Levels levels;               

  Sleep({required this.dateOfSleep, required this.startTime, required this.endTime, required this.duration, required this.minutesToFallAsleep, required this.minutesAsleep, required this.minutesAwake, required this.minutesAfterWakeup, required this.efficiency, required this.logType, required this.mainSleep, required this.levels});

  // Costruttore identico a quello di Steps: riceve 'day' (es. 2024-02-14) e la mappa json
  Sleep.fromJson(String date, Map<String, dynamic> json) :
      dateOfSleep = json["dateOfSleep"] ?? date,
      
      // Estraiamo l'anno dalla stringa 'date' (i primi 4 caratteri, es. "2024") per comporre la stringa temporale corretta
      startTime = json["startTime"] == null 
          ? DateFormat('yyyy-MM-dd').parse(date) 
          : DateFormat('yyyy-MM-dd HH:mm:ss').parse('${date.substring(0, 4)}-${json["startTime"]}'),
          
      endTime = json["endTime"] == null 
          ? DateFormat('yyyy-MM-dd').parse(date) 
          : DateFormat('yyyy-MM-dd HH:mm:ss').parse('${date.substring(0, 4)}-${json["endTime"]}'),
          
      duration = (json["duration"] as num?)?.toInt() ?? 0,
      minutesToFallAsleep = (json["minutesToFallAsleep"] as num?)?.toInt() ?? 0,
      minutesAsleep = (json["minutesAsleep"] as num?)?.toInt() ?? 0,
      minutesAwake = (json["minutesAwake"] as num?)?.toInt() ?? 0,
      minutesAfterWakeup = (json["minutesAfterWakeup"] as num?)?.toInt() ?? 0,
      efficiency = (json["efficiency"] as num?)?.toInt() ?? 0,
      logType = (json["logType"] as String?) ?? 'auto_detected',
      mainSleep = (json["mainSleep"] as bool?) ?? false,
      // Passiamo la data del giorno anche alle classi figlie per usarla come fallback se necessario
      levels = Levels.fromJson(date, json['levels'] ?? {}); 

  @override
  String toString() {
    return 'Sleep(dateOfSleep: $dateOfSleep, minutesAsleep: $minutesAsleep)';
  }
}

// --- CLASSE INTERMEDIA LEVELS ---
class Levels {
  final SleepSummary summary;        
  final List<SleepStageData> data;   

  Levels({required this.summary, required this.data});

  Levels.fromJson(String date, Map<String, dynamic> json) :
      summary = SleepSummary.fromJson(json['summary'] ?? {}), 
      data = json['data'] == null 
          ? [] 
          : (json['data'] as List).map((i) => SleepStageData.fromJson(date, i)).toList();
}

// --- SOTTO-CLASSE SUMMARY ---
class SleepSummary {
  final SleepStageInfo deep;
  final SleepStageInfo wake;
  final SleepStageInfo light;
  final SleepStageInfo rem;
  final SleepStageInfo restless; 

  SleepSummary({required this.deep, required this.wake, required this.light, required this.rem, required this.restless});

  SleepSummary.fromJson(Map<String, dynamic> json) :
      deep = SleepStageInfo.fromJson(json['deep'] ?? {}),
      wake = SleepStageInfo.fromJson(json['wake'] ?? {}),
      light = SleepStageInfo.fromJson(json['light'] ?? {}),
      rem = SleepStageInfo.fromJson(json['rem'] ?? {}),
      restless = SleepStageInfo.fromJson(json['restless'] ?? {}); 
}

// --- INFO SINGOLA FASE ---
class SleepStageInfo {
  final int count;
  final int minutes;
  final int thirtyDayAvgMinutes;

  SleepStageInfo({required this.count, required this.minutes, required this.thirtyDayAvgMinutes});

  SleepStageInfo.fromJson(Map<String, dynamic> json) :
      count = (json['count'] as num?)?.toInt() ?? 0,
      minutes = (json['minutes'] as num?)?.toInt() ?? 0,
      thirtyDayAvgMinutes = (json['thirtyDayAvgMinutes'] as num?)?.toInt() ?? 0;
}

// --- CRONOLOGIA DATA ---
class SleepStageData {
  final DateTime dateTime;
  final String level;      
  final int seconds;       

  SleepStageData({required this.dateTime, required this.level, required this.seconds});

  SleepStageData.fromJson(String date, Map<String, dynamic> json) :
      dateTime = json["dateTime"] == null 
          ? DateFormat('yyyy-MM-dd').parse(date) 
          : DateFormat('yyyy-MM-dd HH:mm:ss').parse('${date.substring(0, 4)}-${json["dateTime"]}'),
      level = (json['level'] as String?) ?? 'unknown',
      seconds = (json['seconds'] as num?)?.toInt() ?? 0;
}