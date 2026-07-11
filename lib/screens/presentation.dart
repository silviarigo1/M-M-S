//This is the presentation page of the app, where the user can see a carrousel with some images and text 
//that explain the main features of the app.

import 'package:flutter/material.dart';
import 'package:mms_app/screens/onboarding.dart';

class PresentationPage extends StatefulWidget {
  const PresentationPage({super.key});

  @override
  State<PresentationPage> createState() => _PresentationPageState();
}

class _PresentationPageState extends State<PresentationPage> {
  final PageController _pageController = PageController();
  final List<Map<String, String>> _slides = [
    {
      "image": "lib/images/screen1.jpg",
      "title": "Welcome to the Home Page",
      "desc": "Here you can see your tiredness level and plan your trips accordingly. Just click on the green button to start your adventure!"
    },
    {
      "image": "lib/images/screen2.jpg",
      "title": "Choose the destinations",
      "desc": ""
    },
    {
      "image": "lib/images/screen3.jpg",
      "title": "Travel Page",
      "desc": "Here the algorithm will suggest you the best route to reach your destination, taking into account your tiredness level and the energy cost of the trip."
    },
    {
      "image": "lib/images/screen4.jpg",
      "title": "Profile Page",
      "desc": "Here you can view and change your profile information and steps aim."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal, 
                itemCount: _slides.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            child: Image.asset(
                            _slides[index]["image"]!,
                            height: 300,
                            fit: BoxFit.contain,
                        ),),),

                        const SizedBox(height: 24),

                        Text(
                          _slides[index]["title"]!,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightGreen,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        /*const SizedBox(height: 10),
                        Text(
                          _slides[index]["desc"]!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),*/
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text("Start", style: TextStyle(color: Colors.white, fontSize: 16)),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) =>  Onboarding()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}