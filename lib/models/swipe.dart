// This model is used to store the data of the swipes and the trips. 
// It is a ChangeNotifier that notifies the listeners when the data changes.

import 'package:flutter/material.dart';
import 'package:mms_app/models/places.dart';

// The Trip class represents a trip with a title, a list of destinations (as Containers), 
// and a list of indices corresponding to the destinations.
class Trip {
  String title;
  List<Container> destinations;
  List<int> indices;
  bool isCompleted;
  List<int> checkedIndices; 
  bool isStarted; 

  Trip({
    required this.title, 
    required this.destinations, 
    required this.indices, 
    this.isCompleted = false,
    this.isStarted = false, // Di base è false
    List<int>? checkedIndices,
  }) : this.checkedIndices = checkedIndices ?? [];

  int get length => destinations.length;
}

class ResultSwipe extends ChangeNotifier{

  List<Container> swipes = [];
  List<int> savedIndices = [];
  List<int> nonSavedIndices = List.generate(Places.mapDest["title"]!.length, (index) => index);

  List<Trip> trips = [];
  String selectedCity = "";
  int selectedIndexCity = 0;

  Trip? _selectedTripData;
  Trip? get currentTrip => _selectedTripData;


// This method is used to start a trip. It sets the selected trip data and notifies the listeners.
  void startTrip(Trip trip) {
    _selectedTripData = trip;
    trip.isStarted = true;
    notifyListeners();
  }

// This method is used to select a trip. It adverts the listeners that the selected trip data has changed.
  void setSelectedCity(String city) {
    selectedCity = city;
    notifyListeners(); 
  }

// This method is used to select a trip by its index. It adverts the listeners that the selected city index has changed.
  void setSelectedIndexCity(int index) {
    selectedIndexCity = index;
    notifyListeners(); 
  }

// This method is used to save a swipe. It adds the swipe to the list of swipes and notifies the listeners.
  void saveSwipe(Container toAdd){
    swipes.add(toAdd);
    notifyListeners();
  }

// This method is used to save an index. 
// It adds the index to the list of saved indices and removes it from the list of non-saved indices. 
  void saveIndex(int index){
    savedIndices.add(index);
    nonSavedIndices.remove(index);
    notifyListeners();
  }
  
  // This method is used to save a trip. 
  // It creates a new trip with the current swipes and saved indices, adds it to the list of trips, and clears the swipes and indices.
  void savePlaces() {
    if (swipes.isNotEmpty) {
      Trip newtrip = Trip(
        title: "Trip to $selectedCity ${trips.length + 1}", // Dynamic title based on the selected city and the number of trips
        destinations: List.from(swipes),
        indices: List.from(savedIndices),
      );
    trips.add(newtrip);
    swipes.clear();
    savedIndices.clear();
    nonSavedIndices.clear();
    nonSavedIndices = List.generate(Places.mapDest["title"]!.length, (index) => index); // Reset nonSavedIndices to include all indices again
    notifyListeners();  
    }
    
  }

// This method is used to clear all swipes and indices.
  void clearSwipes() {
    swipes.clear();
    savedIndices.clear();
    nonSavedIndices.clear();
    nonSavedIndices = List.generate(Places.mapDest["title"]!.length, (index) => index);
    notifyListeners();
  }

// This method is used to remove a destination from the list of saved destinations.
  void trashDest(int index) {
    int originalIndex = savedIndices[index];
    swipes.removeAt(index);
    savedIndices.removeAt(index);
    nonSavedIndices.add(originalIndex);
    notifyListeners();
  }

// This method is used to end a trip. 
  void endTrip() {
    if (_selectedTripData != null) {
      _selectedTripData!.isCompleted = true; 
      _selectedTripData = null;
    }
    

    notifyListeners();
  }


  bool isPlaceChecked(int index) {
    if (_selectedTripData == null) return false;
    return _selectedTripData!.checkedIndices.contains(index);
  }

  // This method is used to check or uncheck a place in the list of checked places.
  void tipPlaceCheck(int index) {
    if (_selectedTripData != null) {
      if (_selectedTripData!.checkedIndices.contains(index)) {
        _selectedTripData!.checkedIndices.remove(index);
      } else {
        _selectedTripData!.checkedIndices.add(index);
      }
      notifyListeners();
    }
  }

}