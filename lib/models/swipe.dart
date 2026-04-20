import 'package:flutter/material.dart';

class Trip {
  String title;
  List<Container> destinations;
  List<int> indices;

  Trip({required this.title, required this.destinations, required this.indices});
}

class ResultSwipe extends ChangeNotifier{

  List<Container> swipes = [];
  List<int> savedIndices = [];

  List<Trip> trips = [];

  


  void saveSwipe(Container toAdd){
    swipes.add(toAdd);
    notifyListeners();
  }

  void saveIndex(int index){
    savedIndices.add(index);
    notifyListeners();
  }
  
  void savePlaces() {
    if (swipes.isNotEmpty) {
      Trip newtrip = Trip(
        title: "Viaggio ${trips.length +1}",
        destinations: List.from(swipes),
        indices: List.from(savedIndices),
      );
    trips.add(newtrip);
    swipes.clear();
    savedIndices.clear();
    notifyListeners();  
      
    }
    
    
  }
  
}