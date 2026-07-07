// This file contains the TravelCard class, which is responsible for creating a list of cards 
// based on the data provided in the Places class. Each card displays information about a travel destination, 
// including its title, image, description, and energy level (represented by battery icons).
// They are used in the Options page of the app, where users can swipe through the available destinations and save the ones they like.

import 'package:flutter/material.dart';
import './places.dart';

class TravelCard {
  
  List<Container> cards = [
    for (int i = 0; i < Places.mapDest["title"]!.length; i++) 
      Container(
        margin: EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 25,
              spreadRadius: 5,
              offset: Offset(0, 0),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            
            // TITLE
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              color: Colors.lightGreen,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Expanded(
                  child: Center(
                    child: Text(
                      Places.mapDest["title"]![i], 
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                  SizedBox(width: 8),  
                ],
              ),
            ),

            // IMAGE
            Container(
              color: Colors.grey[200],
              width: double.infinity,
              child: Image.asset(
                Places.mapDest["image"]![i], 
                height: 250,
                fit: BoxFit.cover,
              ),
            ),

            // DESCRIPTION
            Expanded(
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.all(20),
                color: Colors.grey[300],
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Text(
                    Places.mapDest["description"]![i], 
                    style: TextStyle(fontSize: 16, height: 1.4),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ),
            const Divider(
              height: 15,
            ),

            // ENERGY LEVEL
            emoji(Places.mapDest["pile"]![i]),
            SizedBox(height: 8),
            
          ],
        ),
      ),
  ];

  int get length => cards.length;

  Widget operator [](int? index) {
    return cards[index!];
  }
}

// This function generates a row of battery icons based on the provided energy level (numPile).
Widget emoji(int numPile) {
  const batteryIcon = Icon(Icons.battery_charging_full_outlined, color: Color.fromARGB(255, 198, 40, 40));
  const batteryIcon2 = Icon(Icons.battery_charging_full_outlined, color: Color.fromARGB(255, 82, 198, 40));
  if (numPile == -1){
      return  batteryIcon2;
  }
  return Row(
    mainAxisSize: MainAxisSize.min, 
    children: List.generate(numPile, (index) => batteryIcon),
  );
}