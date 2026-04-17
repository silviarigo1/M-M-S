import 'package:flutter/material.dart';
import './places.dart';

class TravelCard {
  List<Container> cards = [
    Container(
      alignment: Alignment.center,
      color: Colors.blue,
      child: Text(Places.places[0]),
    ),
    Container(
      alignment: Alignment.center,
      color: Colors.red,
      child: Text(Places.places[1]),
    ),
    Container(
      alignment: Alignment.center,
      color: Colors.purple,
      child: Text(Places.places[2]),
    )
  ];

  int get length => cards.length;

  Widget operator [](int? index) {
    return cards[index!];
  }

}

