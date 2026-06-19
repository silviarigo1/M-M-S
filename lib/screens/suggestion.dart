// This is the suggestion page of the app, where the user can see the suggested destinations based on their saved trips,
// thanks to the proposal function


import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mms_app/providers/data_provider.dart';
import '../models/swipe.dart';
import '../models/places.dart';
import 'package:provider/provider.dart';
import '../models/meta_card.dart';

class Suggestion extends StatefulWidget {
  const Suggestion({super.key});

  @override
  State<Suggestion> createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Suggestions for you", 
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: Consumer<ResultSwipe>(
        builder: (context, provider, child) {
          if (provider.trips.isEmpty) {
            return const Center(
              child: Text(
                'No trips saved',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            );
          }
          
          int currentPile = Provider.of<DataProvider>(context, listen: false).currentBattery;
          int dispPile = currentPile - 1;
          final trip = provider.currentTrip;
          List<int> indiciSelezionati = proposal(trip!, dispPile);
          double hours = 0;
          for (int index in indiciSelezionati) {
            hours = hours + Places.mapDest["hours"]![index];
          }
          double minutes = (hours - hours.floor()) * 60;
          String time = "${hours.floor()}:${minutes.round().toString().padLeft(2, '0')}";
          
          return Column(
            children: [
              // Estimated time display
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.access_time, color: Colors.lightGreen),
                    const SizedBox(width: 8),
                    Text(
                      "Estimated time: $time",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              // Destinations
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: indiciSelezionati.length,
                  itemBuilder: (context, i) {
                    int indexDellaMeta = indiciSelezionati[i];
                    // isPari is used to alternate the dispaly of the cards
                    bool isPari = i % 2 == 0;
                    return MetaCardItem(
                      indexDellaMeta: indexDellaMeta,
                      isPari: isPari,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 200),
                      child: Container(
                        width: 2,
                        height: 30, 
                        color: Colors.lightGreen.withValues(alpha: 0.4),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// --- FUNZIONE LOGICA ALGORITMO ---
List<int> proposal(Trip viaggio, int dispPile) {
  List<int> shuffled = List.from(viaggio.indices);
  final randomconSeed = Random(42);
  shuffled.shuffle(randomconSeed);
  List<int> selected = [];
  int pileUsate = 0;
  double tothours = 0;
  for (var dest in shuffled) {
    if (pileUsate + Places.batt[dest] <= dispPile && tothours + Places.mapDest["hours"]![dest] <= 12) {
      selected.add(dest);
      tothours = tothours + Places.mapDest["hours"]![dest];
      pileUsate += Places.batt[dest];
    }
    if (pileUsate == dispPile) break;
  }
  return selected;
}