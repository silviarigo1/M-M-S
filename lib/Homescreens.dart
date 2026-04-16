import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  // List of pages
  final List<Widget> pages = [
    Center(child: Text("Home Page")),
    Center(child: Text("Travel Page")),
    Center(child: Text("Profile Page")),
  ];

  
}

