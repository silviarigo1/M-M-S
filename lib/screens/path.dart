import 'package:flutter/material.dart';
import 'package:mms_app/models/places.dart';
import 'package:provider/provider.dart';
import '../models/swipe.dart';

class Choices extends StatelessWidget{
  Choices({Key? key}) : super(key: key);

  static const routename = "Choices";

  @override
  Widget build(BuildContext context) {
    print('${Choices.routename} built');
    return Scaffold(
      
      body: Center(
          //On the other hand, here we need a Consumer, since we want the UI to update if the notifyListeners() method is called
          // for example, after the tap of the IconButton in the AppBar.
          child: Consumer<ResultSwipe>(
            builder: (context, number, child) {
              return number.swipes.isEmpty
                ? Text('No destinations selected')
                : ListView.builder(
                  itemCount: number.swipes.length,
                  itemBuilder: (context, destIndex){
                    int indexOriginale = number.savedIndices[destIndex];
                    String destinations = Places.places[indexOriginale]; 

                    return Card(
                      elevation: 5,
                      child: ListTile(
                        leading: Icon(Icons.pin_drop),
                        title: Text(destinations),
                      ));
                  }
                );

            },
      ), ),
      );
    
  } //build

} //CartPage

