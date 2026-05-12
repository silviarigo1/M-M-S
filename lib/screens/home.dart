import 'dart:math';
import 'package:mms_app/models/places.dart';
import 'package:mms_app/models/swipe.dart';

import 'package:mms_app/screens/aim.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:mms_app/screens/options.dart';
import 'package:mms_app/screens/profilepage.dart';
import 'package:mms_app/screens/travelpage.dart';
import 'package:dropdown_button2/dropdown_button2.dart'; 
import 'package:shared_preferences/shared_preferences.dart';

//import './login.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectedIndex = 0;
  double? _steps;
  //final double _stepGoal = 10000;
  double? _sleep;
  final double _sleepGoal = 8;
  double _stepGoal = 10000; // Valore di default, verrà sovrascritto da SharedPreferences

  //double? _tiredness;
  //final _tiredness = 0.95;
  // final double _tirednessGoal = 100;

  String? selectedCity;

  @override
  void initState() {
    super.initState();
    _steps = Random().nextDouble() * 10000; 
    _sleep = Random().nextDouble() * _sleepGoal;

    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Legge 'StepsAim'. Se è null (es. onboarding saltato), usa 10000.
      _stepGoal = (prefs.getInt('StepsAim') ?? 10000).toDouble();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final double currentStepGoal = _stepGoal;
    //final double currentStepGoal = Provider.of<AimsProvider>(context).stepsGoal.toDouble();
    double currentTiredness = (_steps! / currentStepGoal) * (1 - (_sleep! / _sleepGoal));
    currentTiredness = currentTiredness.clamp(0.0, 1.0);
    double currentEnergy = 1 - currentTiredness;
    
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
    SafeArea(
  child: Padding(
    padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
    child: Column(
      children: [
        const SizedBox(height: 10),

        // 1. SALUTO INIZIALE
        Align(
          alignment: Alignment.centerLeft,
          child: FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final sharedPreferences = snapshot.data!;
                if (sharedPreferences.getString('Name') != null) {
                  return Text(
                    '👋 Hello ${sharedPreferences.getString('Name')}',
                    style: const TextStyle(
                      fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            );
                } else {
                  return const Text(
                    '👋 Hello user',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  );
                }
              }
              else {
                return const Text(
                  '👋 Hello user',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                );
              }
          } 
            
          ),
          
        ),
        

        const SizedBox(height: 30),

        // 2. DROPDOWN CENTRATO E ICONA AIUTO A DESTRA
        // Usiamo uno Stack così il Dropdown è matematicamente al centro dello schermo
        SizedBox(
          width: double.infinity,
          height: 70,
          child: Stack(
            alignment: Alignment.center,
            children: [
              DropdownButton2<String>(
                isExpanded: true,
                buttonStyleData: ButtonStyleData(
                  height: 70,
                  width: 220,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.lightGreen,
                  ),
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white,
                  ),
                ),
                hint: const Center(
                  child: Text(
                    'Choose the city',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                items: Places.cities.map<DropdownItem<String>>((String item) => DropdownItem<String>(
                  value: item,
                  child: Center(child: Text(item)),
                )).toList(),
                onChanged: (value) {
                  if (value != null) {
                    int index = Places.cities.indexOf(value);
                    Provider.of<ResultSwipe>(context, listen: false).setSelectedIndexCity(index);
                    setState(() {
                      selectedCity = value;
                      Provider.of<ResultSwipe>(context, listen: false).setSelectedCity(selectedCity!);
                    });
                    Future.microtask(() {
                      if (context.mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Options()),
                        );
                      }
                    });
                  }
                },
              ),
              // Posizioniamo l'icona aiuto a destra senza spostare il dropdown
              Positioned(
                right: 80,
                child: IconButton(
                  icon: const Icon(Icons.help_outline, color: Colors.grey),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text("Choose your destination!"),
                        content: const Text("Click on 'Choose City' to select your trip destination!\n\n"
                            "Afterwards, you can customize your trip by picking your favorite attractions; "
                            "swipe right to add an attraction you like, and left to skip it!\n\n"
                            "We'll take care of the rest. Have a great trip!"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Close"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 60),

        // 3. ROW DEI CERCHI (STEPS E TIREDNESS)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // BLOCCO STEPS
            Column(
              children: [
                const Text("Steps", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: CircularProgressIndicator(
                        value: (_steps! / currentStepGoal),
                        strokeWidth: 15,
                        backgroundColor: Colors.grey.withOpacity(0.3),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color.lerp(Colors.blue, Colors.green, (_steps! / currentStepGoal).clamp(0.0, 1.0)) ?? Colors.blue,
                        ),
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("${_steps!.round()}",
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Text("${currentStepGoal.toInt()}",
                            style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            // BLOCCO TIREDNESS
            Column(
              children: [
                const Text("Tiredness", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: CircularProgressIndicator(
                        value: currentTiredness,
                        strokeWidth: 15,
                        backgroundColor: Colors.grey.withOpacity(0.3),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color.lerp(Colors.green, Colors.red, currentTiredness) ?? Colors.green,
                        ),
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    Text(
                      "${(currentTiredness * 100).toInt()}%",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 60),
        Row(
            mainAxisSize: MainAxisSize.min, // Evita che la riga occupi tutto lo schermo
            children: [
              const Text('User battery: [', style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              emoji(currentPile), // Qui Flutter disegnerà le icone vere e proprie
              const Text(']', style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ],
          )
      ],
    ),
  ),
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

Widget emoji(int numPile) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      // Icone verdi (cariche)
      for (int i = 0; i < numPile; i++)
        const Icon(Icons.battery_full_rounded, color: Colors.lightGreen),
      
      // Icone grigie (scariche)
      for (int i = 0; i < (10 - numPile); i++)
        const Icon(Icons.battery_0_bar_rounded, color: Colors.grey),
    ],
  );
}
