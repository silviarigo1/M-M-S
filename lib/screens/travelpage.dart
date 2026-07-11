// This is the travel page of the app, where the user can see an overview of the trips they have saved.
// If the user clicks on a trip, he/she can see all the selected attraction and each associated energy cost.
// The "START" buttons allows to begin the trip and redirect the user to the suggestion page, 
// where the app will propose trip suggestions based on the user's tiredness level.


import 'package:flutter/material.dart';
import 'package:mms_app/models/places.dart';
import 'package:mms_app/providers/data_provider.dart';
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
                                              
                                              Text(Places.batt[indexOriginale] == -1 
                                                ? '+1' 
                                                : "${Places.batt[indexOriginale]}"
                                              ),
                                              
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
                                              // All'interno del ListView.builder di TravelPage
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: Colors.green, width: 2),
                        ),
                        onPressed: 
                            () { final dataProvider = Provider.of<DataProvider>(context, listen: false);

                                  if (!dataProvider.isPresentSleep || !dataProvider.isPresentHeart) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Data not available'),
                                        backgroundColor: Colors.redAccent,
                                      ),
                                    );
                                    return; 
                                  }
                                provider.startTrip(trip);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Suggestion()),
                                );
                              },
                        child: Text(
                          trip.isCompleted 
                              ? 'COMPLETED' 
                              : (trip.isStarted ? 'RESUME' : 'START'),
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


