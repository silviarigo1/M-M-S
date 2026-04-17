import 'package:flutter/material.dart';

class resultSwipe extends ChangeNotifier{
  List<String> swipes = [];

  void saveSwipe(String toAdd){
    swipes.add(toAdd);
    notifyListeners();
  }
}