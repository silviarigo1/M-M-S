import 'package:flutter/material.dart';
import 'package:mms_app/models/places.dart';


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
  List<int> nonSavedIndices = List.generate(Places.mapDest["title"]!.length, (index) => index);
  int currentBattery = 0;

  List<Trip> trips = [];
  String selectedCity = "";
  int selectedIndexCity = 0;

  Trip? _selectedTripData;
  Trip? get currentTrip => _selectedTripData;

  void startTrip(Trip trip) {
    _selectedTripData = trip;
    notifyListeners();
  }

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
    nonSavedIndices.remove(index);

    notifyListeners();
  }
  
  void savePlaces() {
    if (swipes.isNotEmpty) {
      Trip newtrip = Trip(
        title: "Trip to $selectedCity ${trips.length + 1}", // Titolo dinamico basato sulla città e sul numero di viaggi
        destinations: List.from(swipes),
        indices: List.from(savedIndices),
      );
    trips.add(newtrip);
    swipes.clear();
    savedIndices.clear();
    nonSavedIndices.clear();
    nonSavedIndices = List.generate(Places.mapDest["title"]!.length, (index) => index);
    notifyListeners();  
    }
    
  }

  void clearSwipes() {
    swipes.clear();
    savedIndices.clear();
    nonSavedIndices.clear();
    nonSavedIndices = List.generate(Places.mapDest["title"]!.length, (index) => index);
    notifyListeners();
  }

  void trashDest(int index) {
    int originalIndex = savedIndices[index];
    swipes.removeAt(index);
    savedIndices.removeAt(index);
    nonSavedIndices.add(originalIndex);
    
    notifyListeners();
  }

  void saveBattery(int battery) {
    currentBattery = battery;
    notifyListeners();
  }
}