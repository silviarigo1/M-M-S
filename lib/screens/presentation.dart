import 'package:flutter/material.dart';
import 'package:mms_app/screens/onboarding.dart';

class PresentationPage extends StatefulWidget {
  const PresentationPage({super.key});

  @override
  State<PresentationPage> createState() => _PresentationPageState();
}

class _PresentationPageState extends State<PresentationPage> {
  // Il controller ci permette di gestire o monitorare lo scorrimento
  final PageController _pageController = PageController();

  // I dati della tua carrellata (Immagini e Testi)
  final List<Map<String, String>> _slides = [
    {
      "image": "lib/images/screen1.png",
      "title": "Welcome to the Home Page",
      "desc": "Here you can see your tiredness level and plan your trips accordingly. Just click on the green button to start your adventure!"
    },
    {
      "image": "lib/images/screen2.png",
      "title": "Travel Page",
      "desc": "Here the algorithm will suggest you the best route to reach your destination, taking into account your tiredness level and the energy cost of the trip."
    },
    /*{
      "image": "lib/images/screen3.png",
      "title": "Profile Page",
      "desc": "Here you can view and change your profile information and steps aim."
    },*/
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // L'area sacrificata alla PageView deve essere flessibile (Expanded)
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal, // <--- FORZA LO SCROLL VERSO DESTRA
                itemCount: _slides.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Immagine del tutorial
                        Image.asset(
                          _slides[index]["image"]!,
                          height: 300,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 30),
                        // Titolo
                        Text(
                          _slides[index]["title"]!,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightGreen,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        // Descrizione
                        Text(
                          _slides[index]["desc"]!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            // Pulsante in basso per saltare o andare avanti
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