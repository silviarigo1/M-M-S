import 'package:flutter/material.dart';

class ResultSwipe extends ChangeNotifier{

  List<Container> swipes = [];

  void saveSwipe(Container toAdd){
    swipes.add(toAdd);
    notifyListeners();
  }
}