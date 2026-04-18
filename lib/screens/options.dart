import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:mms_app/models/swipe.dart';
import 'package:mms_app/screens/path.dart';
import 'package:provider/provider.dart';
import '../models/card.dart';

class Options extends StatelessWidget {
  Options({super.key});

  final TravelCard carte =  TravelCard();

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
          cardsCount: carte.length,
          cardBuilder: (context, index) => carte[index],
          onSwipe:(previousIndex, currentIndex, direction) {
            if(direction == CardSwiperDirection.right){
                Provider.of<ResultSwipe>(context, listen: false).saveSwipe(carte.cards[previousIndex!]);
                Provider.of<ResultSwipe>(context, listen: false).saveIndex(previousIndex);
            }
            if (previousIndex == carte.length -1) {
              Future.delayed(Duration.zero, () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Choices()),
                );
              });
            }
            })));
            }
}




