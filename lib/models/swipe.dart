import 'package:flutter/material.dart';

class Trip {
  String title;
  List<Container> destinations;
  List<int> indices;

  Trip({required this.title, required this.destinations, required this.indices});
  int get length => destinations.length;

}

class ResultSwipe extends ChangeNotifier{

  List<Container> swipes = [];
  List<int> savedIndices = [];

  List<Trip> trips = [];
  String selectedCity = "";
  int selectedIndexCity = 0;

  void setSelectedCity(String city) {
    selectedCity = city;
    notifyListeners(); // Avvisa tutti che la città è cambiata
  }

  void setSelectedIndexCity(int index) {
    selectedIndexCity = index;
    notifyListeners(); // Avvisa tutti che la città è cambiata
  }


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
        title: "Trip to ${selectedCity}",
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