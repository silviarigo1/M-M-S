import 'package:flutter/material.dart';

class ResultSwipe extends ChangeNotifier{

  List<Container> swipes = [];
  List<int> savedIndices = [];

  void saveSwipe(Container toAdd){
    swipes.add(toAdd);
    notifyListeners();
  }

  void saveIndex(int index){
    savedIndices.add(index);
    notifyListeners();
  }
}