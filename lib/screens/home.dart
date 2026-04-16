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

  
  @override
  Widget build(BuildContext context) {

    final List<String> titles = [
      "Home",
      "Your trips",
      "Profile",
    ];
    // List of pages
    final List<Widget> pages = [
    Center(child: ElevatedButton(
    onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Options()));}, 
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.lightGreen, 
      foregroundColor: Colors.black,
      minimumSize: const Size(400, 120),),
    child: Text("Crea percorso", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),),
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