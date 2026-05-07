import 'package:flutter/material.dart';
import 'home.dart';
import '../models/swipe.dart';
import '../models/places.dart';
import 'package:provider/provider.dart';

class Suggestion extends StatefulWidget {
  const Suggestion({super.key});

  @override
  State<Suggestion> createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  @override
  Widget build(BuildContext context) {
    
    // Supponiamo che questi dati arrivino da qualche parte (es. SharedPreferences o Provider)

    

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
          // --- LOGICA SPOSTATA QUI ---
          final trip = provider.trips[0];
          // Chiamiamo la tua funzione Proposte
          List<int> indiciSelezionati = Proposte(trip, dispPile);

          return ListView.builder(
            itemCount: indiciSelezionati.length,
            itemBuilder: (context, i) {
              int indexDellaMeta = indiciSelezionati[i];
              // Qui recuperi i dati della meta usando l'indice
              return ListTile(
                title: Text("Destination: ${Places.mapDest["title"]![indexDellaMeta]}"),
                subtitle: Text("Cost: ${Places.batt[indexDellaMeta]} 🪫"),
              );
            },
          );
        },
      ),
    );
  }
}

List<int> Proposte(Trip viaggio, int dispPile) {
  List<int> shuffled = List.from(viaggio.indices);
  shuffled.shuffle();
  List<int> selected = [];
  int pileUsate = 0;
  for (var dest in shuffled) {
    // Controlliamo se questa specifica meta entra nello spazio rimanente
    if (pileUsate + Places.batt[dest] <= dispPile) {
      selected.add(dest);
      pileUsate += Places.batt[dest];
    }
    if (pileUsate == dispPile) break;
  }

  return selected;


}