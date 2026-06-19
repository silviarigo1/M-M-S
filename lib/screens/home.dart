//This is the home page of the app, where the user can see the main features of the app and navigate to other pages.
//There is a bottom navigation bar that allows the user to navigate between the home page, the trips page and 
//the profile page. By default, the home page is selected and the user can see the home dashboard.

import 'package:mms_app/screens/homedashboard.dart';
import 'package:flutter/material.dart';
import 'package:mms_app/screens/profilepage.dart';
import 'package:mms_app/screens/travelpage.dart';

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
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined,),
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



