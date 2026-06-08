import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';
import '../utils/impact.dart';


class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
  // Il tuo solito timer per cambiare pagina dopo 3 secondi
  Future.delayed(const Duration(seconds: 3, milliseconds: 200), () => _checkLogin(context));

  return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ Stack(
          alignment: Alignment.center,
          children: [
          // Il costruttore che ascolta il flusso del tempo
          StreamBuilder<double>(
            // Questo comando crea un flusso che dura 3 secondi e aggiorna il valore continuamente
            stream: Stream.periodic(const Duration(milliseconds: 30), (x) => x * 0.01).take(101),
            builder: (context, snapshot) {
              return SizedBox(
                width: 140,
                height: 140,
                child: CircularProgressIndicator(
                  // snapshot.data è il numero che cresce da 0.0 a 1.0
                  value: snapshot.data ?? 0.0, 
                  strokeWidth: 5,
                  color: Colors.lightGreen,
                  backgroundColor: Colors.grey.shade200,
                ),
              );
            },
          ),
          // Il tuo logo fisso al centro
          Image.asset('lib/images/logonuovo.jpeg', height: 80, width: 80),
        

        ]
      ),
    
      SizedBox(height: 20),
      Text('WELCOME TO MMS TRIP', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.lightGreen)),
        ],
      ),
    ),

  );
  
}

  // Method for navigation SplashPage -> HomePage
  void _toHomePage(BuildContext context) {
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
      _toHomePage(context);
    } else {
      _toLoginPage(context);
    }
  } //_checkLogin

}