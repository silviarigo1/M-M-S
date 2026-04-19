import 'package:flutter/material.dart';
import 'package:mms_app/models/places.dart';
import 'package:provider/provider.dart';
import '../models/swipe.dart';

class Choices extends StatelessWidget {
  Choices({Key? key}) : super(key: key);

  static const routename = "Choices";

  @override
  Widget build(BuildContext context) {
    print('${Choices.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Padova trip',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ), // Fine AppBar

      body: Consumer<ResultSwipe>(
        builder: (context, number, child) {
          return number.swipes.isEmpty
              ? const Center(child: 
                Text(
                  'No destinations selected',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)))
                
              : ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: number.swipes.length,
                  itemBuilder: (context, destIndex) {
                    int indexOriginale = number.savedIndices[destIndex];
                    String destinations = Places.places[indexOriginale];

                    return Card(
                      elevation: 5,
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
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ); // Fine Card
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 28),
                      child: Container(
                        width: 2,
                        height: 30,
                        color: Colors.lightGreen.withOpacity(0.4),
                      ),
                    ); // Fine Container separatore
                  },
                ); // Fine ListView
        }, // Fine Builder
      ), // Fine Consumer
    ); // Fine Scaffold (Qui serve il punto e virgola!)
  } // Fine build
} // Fine classe