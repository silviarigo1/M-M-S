import 'package:flutter/material.dart';
import 'package:mms_app/utils/impact.dart';


class DataProvider extends ChangeNotifier {
  int? stepsTotal = 0;
  final Impact impact = Impact();

Future<int?> getStepsTotal() async {
    stepsTotal = await impact.stepsTotal();
    notifyListeners();
    return stepsTotal;
    
  }
}