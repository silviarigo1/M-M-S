import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';
import '../utils/impact.dart';


class Temporary extends StatelessWidget {
  const Temporary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () => _checkLogin(context));
    return Scaffold(
        body: Center(
            child: Image.asset(
      'assets/logo.png',
      scale: 4,
    )));
  }

  // Method for navigation SplashPage -> ExposurePage
  void _toExposurePage(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
  } 

  // Method for navigation SplashPage -> LoginPage
  void _toLoginPage(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: ((context) =>  LoginPage())));
  } 

  // Method for checking if the user has still valid tokens
  // If yes, navigate to ExposurePage, if not, navigate to LoginPage
  void _checkLogin(BuildContext context) async {
    final result = await Impact().refreshTokens();
    if (result == 200) {
      _toExposurePage(context);
    } else {
      _toLoginPage(context);
    }
  } //_checkLogin

}