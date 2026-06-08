import 'dart:math';

import 'package:flutter/material.dart';

import '../models/swipe.dart';
import '../models/places.dart';
import 'package:provider/provider.dart';


/*class Suggestion extends StatefulWidget {
  const Suggestion({super.key});

  @override
  State<Suggestion> createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  @override
  Widget build(BuildContext context) {
    
    bool tick = false;

    

    return Scaffold(
      appBar: AppBar(
        title: Text("Suggestions for you", style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.lightGreen
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
          
          int currentPile = provider.currentBattery;
          int dispPile = currentPile - 1;
          
          final trip = provider.trips[0];
          
          List<int> indiciSelezionati = Proposte(trip, dispPile);
          double hours = 0;
          for (int index in indiciSelezionati) {
            hours = hours + Places.mapDest["hours"]![index];
          }
          double minutes = (hours - hours.floor()) * 60;
          String time = hours.floor().toString() + ":" + minutes.toString();
          
          return Column(
            children: [
              // --- SEZIONE TEMPO STIMATO ---
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

          Expanded(child:  ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            
            itemCount: indiciSelezionati.length,
            itemBuilder: (context, i) {
              
              int indexDellaMeta = indiciSelezionati[i];
              bool isPari = i % 2 == 0;
              return Padding(
    
              padding: EdgeInsets.only(
                
                left: isPari ? 10 : 80, 
                right: isPari ? 80 : 10,
                
              ),
              
              child: Card(
                elevation: 5,
                
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  leading: Image.asset(
                    Places.mapDest["image"]![indexDellaMeta],
                    width: 70,
                    height: 70,
                    fit: BoxFit.contain,
                  ),
                  title: Text("${Places.mapDest["title"]![indexDellaMeta]}"),
                subtitle: Row(
                  mainAxisSize: MainAxisSize.min,   
                  children: [ 
                    // Testo dinamico
                    Text(Places.batt[indexDellaMeta] == -1 
                      ? '+1' 
                      : "Cost: ${Places.batt[indexDellaMeta]}"
                    ),
                    // Icona con colore dinamico
                    Icon(
                      Icons.battery_charging_full_outlined, 
                      color: Places.batt[indexDellaMeta] == -1
                        ? const Color.fromARGB(255, 82, 198, 40)  // Verde
                        : const Color.fromARGB(255, 198, 40, 40), // Rosso
                    ),
                  ],
                ),
                trailing: Checkbox(
                          value: tick,
                          activeColor: Colors.lightGreen,
                          onChanged: (bool? value) {
                            setState((){
                              tick = value ?? false;
                            })
                          }
                          icon: const Icon(
                            Icons.delete_rounded,
                            color: Color.fromARGB(255, 93, 92, 92),
                          ),
                          onPressed: () {
                            
                            setState(() {number.TrashDest(destIndex);});
                            ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Destination removed!")),);
                          }
                          
                        ),
              ),
              ),
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.only(left: 200),
                                        child: Container(
                                          width: 2,
                                          height: 30, 
                                          color: Colors.lightGreen.withOpacity(0.4),
                                        ),
                                      );
            },
          ),),
            ]
          
          );
        },
      ),
    );
  }
}

List<int> proposte(Trip viaggio, int dispPile) {
  List<int> shuffled = List.from(viaggio.indices);
  shuffled.shuffle();
  List<int> selected = [];
  int pileUsate = 0;
  double Tothours = 0;
  for (var dest in shuffled) {
    
    if (pileUsate + Places.batt[dest] <= dispPile && Tothours + Places.mapDest["hours"]![dest] <= 12) {
      selected.add(dest);
      Tothours = Tothours + Places.mapDest["hours"]![dest];
      pileUsate += Places.batt[dest];
    }
    if (pileUsate == dispPile) break;
  }

  return selected;


}*/

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
          
          int currentPile = provider.currentBattery;
          int dispPile = currentPile - 1;
          
          final trip = provider.currentTrip;
          
          List<int> indiciSelezionati = proposal(trip!, dispPile);
          double hours = 0;
          for (int index in indiciSelezionati) {
            hours = hours + Places.mapDest["hours"]![index];
          }
          double minutes = (hours - hours.floor()) * 60;
          // Mostra i minuti sempre a due cifre (es. 1:05 invece di 1:5)
          String time = "${hours.floor()}:${minutes.round().toString().padLeft(2, '0')}";
          
          return Column(
            children: [
              // --- SEZIONE TEMPO STIMATO ---
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

              // --- LISTA DELLE METE ---
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: indiciSelezionati.length,
                  itemBuilder: (context, i) {
                    int indexDellaMeta = indiciSelezionati[i];
                    bool isPari = i % 2 == 0;
                    
                    // Richiamiamo il widget autonomo che gestisce la sua checkbox
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