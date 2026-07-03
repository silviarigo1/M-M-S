//This is the travel page of the app, where the user can see the trips they have saved and start a trip.
//If you click on a trip, you can see the stages of the trip and the energy cost of each stage. 
//You can also start a trip by clicking on the "START" button.
//When you click start, the app will propose trip suggestions based on the user's tiredness level and the energy cost of the trip.

import 'package:flutter/material.dart';
import 'package:mms_app/models/places.dart';
import 'package:mms_app/screens/suggestion.dart';
import 'package:provider/provider.dart';
import '../models/swipe.dart';

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
                    bool isFaded = provider.isOngoing && provider.currentTrip != trip;

                    return IgnorePointer(
                      ignoring: isFaded,
                      child: Opacity(
                        opacity: isFaded ? 0.5 : 1.0,
                      child: Card(
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
                                  borderRadius: BorderRadius.circular(15), 
                                  image: DecorationImage(
                                    image: const AssetImage('lib/images/mete/PratoValle.jpg'), 
                                    fit: BoxFit.cover, 
                                    colorFilter: ColorFilter.mode(
                                      Colors.white.withValues(alpha: 0.40), 
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
                                        color: Colors.white.withValues(alpha: 0.9),
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
                                              // If the destination lets you recharge, show a green icon, otherwise show a red icon
                                              Icon(
                                                Icons.battery_charging_full_outlined, 
                                                color: Places.batt[indexOriginale] == -1
                                                  ? const Color.fromARGB(255, 82, 198, 40)  
                                                  : const Color.fromARGB(255, 198, 40, 40), 
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
                                          color: Colors.lightGreen.withValues(alpha: 0.4),
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
                              color: Colors.green, 
                              width: 2,            
                            ),
                          ),
                          onPressed: () { provider.startTrip(trip);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Suggestion()),
                          );
                        },
                        child: Text(
                          provider.isOngoing && provider.currentTrip == trip
                              ? 'RESUME'
                              : 'START'
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ); 
          },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                                  height: 20, 
                            ); 
                  },
                ); 
        }, 
      ), 
    );
  }
}
