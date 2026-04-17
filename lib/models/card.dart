import 'package:flutter/material.dart';

class TravelCard {
  List<String> places = ["Posto 1", "Posto 2", "Posto 3"];

  List<Container> cards = [
    Container(
      alignment: Alignment.center,
      color: Colors.blue,
      child: Text(places[1]),
    ),
    Container(
      alignment: Alignment.center,
      color: Colors.red,
      child: const Text('2'),
    ),
    Container(
      alignment: Alignment.center,
      color: Colors.purple,
      child: const Text('3'),
    )
  ];

  int get length => cards.length;

  Widget operator [](int? index) {
    return cards[index!];
  }

}

