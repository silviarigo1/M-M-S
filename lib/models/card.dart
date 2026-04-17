import 'package:flutter/material.dart';

class TravelCard {
  List<Container> cards = [
    Container(
      alignment: Alignment.center,
      child: const Text('Venezia'),
      color: Colors.blue,
    ),
    Container(
      alignment: Alignment.center,
      child: const Text('2'),
      color: Colors.red,
    ),
    Container(
      alignment: Alignment.center,
      child: const Text('3'),
      color: Colors.purple,
    )
  ];

  int get length => cards.length;

  Widget operator [](int? index) {
    return cards[index!];
  }

}

