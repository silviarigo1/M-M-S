import 'dart:math';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mms_app/models/places.dart';
import 'package:mms_app/models/steps.dart';
import 'package:mms_app/models/swipe.dart';
import 'package:mms_app/providers/data_provider.dart';
import 'package:mms_app/screens/aim.dart';
import 'package:mms_app/screens/homedashboard.dart';
import 'package:mms_app/utils/impact.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:mms_app/screens/options.dart';
import 'package:mms_app/screens/profilepage.dart';
import 'package:mms_app/screens/travelpage.dart';
import 'package:dropdown_button2/dropdown_button2.dart'; 
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  double _steps = 0;
  double? _sleep;
  final double _sleepGoal = 8;
  double currentStepGoal = 10000; // Valore di default, verrà sovrascritto da SharedPreferences
  String? selectedCity;
  @override
  void initState() {
    super.initState();
    _sleep = Random().nextDouble() * _sleepGoal;
    _loadSettings(); // Carica i dati una volta sola all'inizio
  }
  Future<void> _loadSettings() async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      currentStepGoal = (sp.getInt('StepsAim') ?? 10000).toDouble();
    });
  }
  @override
  Widget build(BuildContext context) {
    double currentTiredness = (_steps / currentStepGoal) * (1 - (_sleep! / _sleepGoal));
    currentTiredness = currentTiredness.clamp(0.0, 1.0);
    double currentEnergy = 1 - currentTiredness;
    final impact = Impact();
    int currentPile;
    if (currentEnergy > 0.9) {
      currentPile = 10;
    }
    else if (currentEnergy < 0.15) {
      currentPile = 1;
    } else {
      currentPile = (currentEnergy / 0.1).round();
    }
    Provider.of<ResultSwipe>(context, listen: false).saveBattery(currentPile);
    final List<String> titles = [
      "Home",
      "My trips",
      "Profile",
    ];
    // List of pages
    final List<Widget> pages = [
    HomeDashboard(),
    TravelPage(),
    Profile(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[selectedIndex], style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.lightGreen
      ),
      body:         
          pages[selectedIndex],
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
            icon: Icon(Icons.airplane_ticket_outlined),
            selectedIcon: Icon(Icons.airplane_ticket_rounded),
            label: "Trips",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_2_outlined),
            selectedIcon: Icon(Icons.person_2_rounded),
            label: "Profile",
          ),
        ],
      ),
    );
}}



