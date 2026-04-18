import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mms_app/screens/options.dart';
import 'package:mms_app/screens/profilepage.dart';
import 'package:mms_app/screens/travelpage.dart';

//import './login.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  double? _steps;
  final double _stepGoal = 10000;

  double? _sleep;
  final double _sleepGoal = 8;

  double? _tiredness;
  //final double _tirednessGoal = 100;

  @override
  void initState(){
    _steps = Random().nextDouble() * _stepGoal;
    _sleep = Random().nextDouble() * _sleepGoal;
    _tiredness = (_steps!/_stepGoal) * (1-(_sleep!/_sleepGoal));
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {

    final List<String> titles = [
      "Home",
      "Your trips",
      "Profile",
    ];
    // List of pages
    final List<Widget> pages = [
    Center( 
      child: Padding(
                padding: const EdgeInsets.only(left:8.0, right: 8.0, top: 10.0, bottom: 4.0),
                child: Column (
                  children: [
                      ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Options()));}, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen, 
                          foregroundColor: Colors.black,
                          minimumSize: const Size(300, 100),),
                        child: Text("Crea percorso", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),),
                      
                      const SizedBox(
                              height: 30,
                            ),

                      const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("I tuoi passi oggi:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                            ),
                            const SizedBox(height: 3),

                      
                      Container(
                        margin: const EdgeInsets.only(top:20, bottom:10),
                        height: 15,
                        child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                        value: _steps! / _stepGoal,
                        backgroundColor: Colors.grey.withOpacity(0.5),
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.lightGreen),
                      )),),

                      const SizedBox(
                              height: 20,
                            ),

                      const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Quanto sei stanco oggi:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                            ),
                            const SizedBox(height: 8),
                      
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: CircularProgressIndicator(
                              value: _tiredness,
                              strokeWidth: 12,
                              backgroundColor: Colors.grey.withOpacity(0.5),
                              color: Colors.lightGreen,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
                              strokeCap: StrokeCap.round,
                            ),
                          )
                        ],
                      )

                      
                  ],),),


            
    ),


    TravelPage(),
    Profile(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[selectedIndex], style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.lightGreen
      ),
      body:pages[selectedIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,

        // When user taps an item
        onDestinationSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },

        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.airplanemode_active),
            selectedIcon: Icon(Icons.airplanemode_active),
            label: "Trips",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_2_rounded),
            selectedIcon: Icon(Icons.person_2_rounded),
            label: "Profile",
          ),
        ],
      ),
    );
}}