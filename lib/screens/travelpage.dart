import 'package:flutter/material.dart';
import 'package:mms_app/models/places.dart';
import 'package:mms_app/screens/suggestion.dart';
import 'package:provider/provider.dart';
import '../models/swipe.dart';
import 'package:nps_survey/nps_survey.dart';




class TravelPage extends StatelessWidget {
  const TravelPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      body: Consumer<ResultSwipe>(
        builder: (context, provider, child) {
          return provider.trips.isEmpty
              ? const Center(child: 
                Text(
                  'No trips saved',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)))
                
              : ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: provider.trips.length,
                  itemBuilder: (context, tripIndex) {
                    final trip = provider.trips[tripIndex];
                    int index = provider.selectedIndexCity;

                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                                title: const Center( 
                                  child:Text("TRIP STAGES", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),)),
                               
                                content: Container( 
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15), // Smussa gli angoli dello sfondo come il box
                                  image: DecorationImage(
                                    image: const AssetImage('lib/images/mete/PratoValle.jpg'), // Metti qui il percorso della tua immagine
                                    fit: BoxFit.cover, // Fa occupare all'immagine tutto lo spazio disponibile
                                    // --- TRASPARENTINO ---
                                    // Questo filtro applica il bianco con un'opacità dello 0.15 (85% trasparente)
                                    colorFilter: ColorFilter.mode(
                                      Colors.white.withOpacity(0.40), 
                                      BlendMode.dstATop,
                                    ),
                                  ),
                                ), 
                                  child: ListView.separated(
                                    shrinkWrap: true, 
                                    padding: const EdgeInsets.all(10),
                                    itemCount: trip.length,
                                    itemBuilder: (context, destIndex) {
                                      int indexOriginale = trip.indices[destIndex];
                                      String destinations = Places.mapDest["title"]![indexOriginale];

                                      return Card(
                                        elevation: 3,
                                        margin: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15)),
                                        color: Colors.white.withOpacity(0.9),
                                        child: ListTile(
                                          leading: const Icon(
                                            Icons.pin_drop,
                                            color: Colors.lightGreen,
                                          ),
                                          title: Text(
                                            destinations,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14, 
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,   
                                            children: [ 
                                              // Testo dinamico
                                              Text(Places.batt[indexOriginale] == -1 
                                                ? '+1' 
                                                : "${Places.batt[indexOriginale]}"
                                              ),
                                              // Icona con colore dinamico
                                              Icon(
                                                Icons.battery_charging_full_outlined, 
                                                color: Places.batt[indexOriginale] == -1
                                                  ? const Color.fromARGB(255, 82, 198, 40)  // Verde
                                                  : const Color.fromARGB(255, 198, 40, 40), // Rosso
                                              ),
                                            ],
                                          ),
                                          
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Container(
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.only(left: 28),
                                        child: Container(
                                          width: 2,
                                          height: 20, 
                                          color: Colors.lightGreen.withOpacity(0.4),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Close", style: TextStyle(color: Colors.lightGreen)),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: ListTile(
                        
                        leading: Image.asset(
                          Places.images[index],
                                            
                          ),
                        title: Text(
                          trip.title,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.green, // Colore del bordo
                              width: 2,            // Spessore del bordo
                            ),
                          ),
                          onPressed: () { provider.startTrip(trip);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Suggestion()),
                          ).then((_) {
                            // 2. Al ritorno, mostriamo il sondaggio con la sintassi esatta di pub.dev
                            NPSSurvey().showNPSDialog(
                              context: context,
                              callback: (feedback, score) {
                                // feedback contiene il testo scritto dall'utente
                                // score contiene il voto numerico da 0 a 10
                                print('Commento dell\'utente: $feedback');
                                print('Voto dell\'utente: $score');
                              },
                            );
                          });
                        },
                        child: const Text('START'))
                        

                      ),
                      ),
                      
                      
                    ); 
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                                    height: 20, // Modifica questo valore per aumentare o diminuire lo spazio
                            ); 
                  },
                ); 
        }, 
      ), 
    );
  }
}
