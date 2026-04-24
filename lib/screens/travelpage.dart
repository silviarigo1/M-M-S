import 'package:flutter/material.dart';
import 'package:mms_app/models/places.dart';
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
                                title: const Text("Trip stages"),
                                content: SizedBox( 
                                  width: double.maxFinite, 
                                  child: ListView.separated(
                                    shrinkWrap: true, 
                                    padding: const EdgeInsets.all(10),
                                    itemCount: trip.length,
                                    itemBuilder: (context, destIndex) {
                                      int indexOriginale = trip.indices[destIndex];
                                      String destinations = Places.places[indexOriginale];

                                      return Card(
                                        elevation: 3,
                                        margin: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15)),
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
