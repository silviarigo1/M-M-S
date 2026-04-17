import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:mms_app/models/swipe.dart';

class Options extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ciao')
      ),
      body: Flexible(
        child: CardSwiper(
          isVerticalSwipingEnabled: false,
          isLoop: false,
          cardsCount: cards.length,
          cardBuilder: (context, index) => cards[index],
        ),
      ),
    );
  }
}

void _save(BuildContext context){
  if(CardSwiperDirection.right == true){
    resultSwipe.saveSwipe()
  }
}

