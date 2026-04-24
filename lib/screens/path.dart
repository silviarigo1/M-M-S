import 'package:flutter/material.dart';
import 'package:mms_app/models/places.dart';
import 'package:mms_app/screens/home.dart';

import 'package:provider/provider.dart';
import '../models/swipe.dart';

class Choices extends StatefulWidget {
  Choices({Key? key}) : super(key: key);

  static const routename = "Choices";

  @override
  State<Choices> createState() => _ChoicesState();
}

class _ChoicesState extends State<Choices> {
  @override
  Widget build(BuildContext context) {
    print('${Choices.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trip recap',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ), 

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
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_rounded,
                            color: Color.fromARGB(255, 93, 92, 92),
                          ),
                          onPressed: () {
                            
                            setState(() {number.TrashDest(destIndex);});
                          }
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
                        height: 30,
                        color: Colors.lightGreen.withOpacity(0.4),
                      ),
                    ); 
                  },
                ); 
        }, 
      ), 
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children:[
          FloatingActionButton(
            mini: true,
        
        onPressed: () {
          
        },
        backgroundColor: Colors.lightGreen,
        child: const Icon(
          Icons.add,
          color: Colors.white,),
        ),
        const SizedBox(height: 20),
        FloatingActionButton(
        onPressed: () {
          Provider.of<ResultSwipe>(context, listen: false).savePlaces();
          Navigator.pushAndRemoveUntil( context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Trip saved!")),
          );
        },
        backgroundColor: Colors.lightGreen,
        child: const Icon(
          Icons.save,
          color: Colors.white,),
        ),
        ],
      ),
      
    ); 
  } 
} 