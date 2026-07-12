// This page is the first screen that is called when the app is opened. 
// It shows a splash screen with a loading animation and the logo of the app.
// Then, it checks if the user has still valid tokens. If yes, it navigates to the HomePage, if not, it navigates to the LoginPage.

import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';
import '../utils/impact.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    _startTimerandCheck();
  }

  void _startTimerandCheck() async{
    await Future.delayed(const Duration(seconds: 3, milliseconds: 200),);
    final result = await Impact().refreshTokens();

    if (!mounted) return; 
    if (result == 200) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3, milliseconds: 200));
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ Stack(
          alignment: Alignment.center,
          children: [
          
          StreamBuilder<double>(
            stream: Stream.periodic(const Duration(milliseconds: 30), (x) => x * 0.01).take(101),
            builder: (context, snapshot) {
              return SizedBox(
                width: 140,
                height: 140,
                child: CircularProgressIndicator(
                  value: snapshot.data ?? 0.0, 
                  strokeWidth: 5,
                  color: Colors.lightGreen,
                  backgroundColor: Colors.grey.shade200,
                ),
              );
            },
          ),
          Image.asset('lib/images/logonuovo.jpeg', height: 80, width: 80),
        ]
      ),
      SizedBox(height: 20),
      Text('WELCOME TO\n M&MS TRIP', textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.lightGreen)),
        ],
      ),
    ),
  ); 
}//_checkLogin

}