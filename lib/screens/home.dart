import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mms_app/screens/options.dart';
import 'package:mms_app/screens/profilepage.dart';
import 'package:mms_app/screens/travelpage.dart';
import 'package:dropdown_button2/dropdown_button2.dart'; 

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
  //final _tiredness = 0.95;
  // final double _tirednessGoal = 100;

  String? selectedCity;

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
      "My trips",
      "Profile",
    ];
    // List of pages
    final List<Widget> pages = [
    Center( 
      child: Padding(
                padding: const EdgeInsets.only(left:8.0, right: 8.0, top: 10.0, bottom: 4.0),
                child: Column (
                  children: [
                    const SizedBox(height: 10,),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Ciao Utente,',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    const SizedBox(height: 60,),
                    
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min, // La Row stringe la sua larghezza al minimo necessario
                        mainAxisAlignment: MainAxisAlignment.center, // Centra orizzontalmente
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                        
                          DropdownButton2<String>(
                                
                            isExpanded: true,
                                // Qui definisci lo stile del "pulsante" che l'utente vede
                            buttonStyleData: ButtonStyleData(
                              height: 70,
                              width: 220,
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.lightGreen,
                              ),
                            ),
                                // Qui definisci lo stile del menu che appare
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.white,
                              ),
                            ),
                            hint: const Text(
                              'Scegli città', 
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            items: ['Padova', 'Milano', 'Bologna', 'Roma', 'Napoli', 'Palermo']
                                .map<DropdownItem<String>>((String item) => DropdownItem<String>(
                                      value: item,
                                      child: Text(item),
                                    ))
                                .toList(),
                              
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  selectedCity = value;
                                });
                                Future.microtask(() {
                                  if (context.mounted) { // Verifica di sicurezza per il context
                                    Navigator.push(
                                      context, 
                                      MaterialPageRoute(builder: (context) => Options()),
                                    );
                                  }
                                });
                              };
                            },
                        ), 

                        const SizedBox(width: 20),
                         // Spazio tra il Dropdown e l'IconButton
                        IconButton(
                          icon: const Icon(Icons.help_outline),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Scegli la tua destinazione!"),
                                  content: const Text("Clicca su: 'Scegli città' per scegliere la destinazione del tuo viaggio!\n\n"
                                                    "In seguito, potrai personalizzare il tuo viaggio scegliendo le attrazioni che prefersci,"
                                                    " fai swipe a destra per aggiungere un'attrazione desiderata, a sinsitra per rimuoverla!\n\n"
                                                    "Al resto ci pensiamo noi, buon viaggio!"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Chiudi"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),  
                    ],
                  ), 
                ), 

              const SizedBox(height: 60,),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text("I tuoi passi oggi:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              ),
                            
              const SizedBox(height: 3),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Allinea il testo a sinistra
                children: [
                    Align(
                      alignment: Alignment.centerRight, 
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4.0, bottom: 4.0), // Padding ora a destra
                        child: Text(
                          '${_steps!.round()} / $_stepGoal passi',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                        
                    Container(
                      margin: const EdgeInsets.only(top:20, bottom:10),
                      height: 15,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                          value: _steps! / _stepGoal,
                          backgroundColor: Colors.grey.withOpacity(0.5),
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.lightGreen),
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 20,),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Quanto sei stanco oggi:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
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
                      backgroundColor: Colors.grey.withOpacity(0.3),
                      // valueColor sovrascrive la proprietà color, quindi usiamo dynamicColor qui
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color.lerp(Colors.green, Colors.red, _tiredness!) ?? Colors.green,
            ),
                      strokeCap: StrokeCap.round,
                    ),
                  ),

                  Text(
                    "${(_tiredness! * 100).toInt()}%",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.lerp(Colors.green, Colors.red, _tiredness!) ?? Colors.green, // Anche il testo cambia colore!
                    ),
                  ),
                ],
              ),   
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