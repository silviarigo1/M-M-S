import 'package:flutter/material.dart';
import 'package:mms_app/models/swipe.dart';
import 'package:mms_app/providers/data_provider.dart';
import 'package:mms_app/screens/splash.dart';
import 'package:provider/provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider( //vedi esempio prof lezione 15 maggio
      providers: [
        ChangeNotifierProvider(create: (context) => ResultSwipe(), ),
        ChangeNotifierProvider(create: (context) => DataProvider()), 
         
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Login Page',
          home:  Splash(),
          /*FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          //If the instance is ready...
          if (snapshot.hasData) {
            //...get the instance
            final sharedPreferences = snapshot.data!;
            //Check if the flag isUserLogged exist...
            if (sharedPreferences.getBool('isUserLogged') != null) {
              //..if so, go directly to HomePage
              return HomeScreen();
            } //if
            else {
              //...otherwise go to LoginPage
              return LoginPage();
              
            } //else
          } //if
          else {
            //While the instance of SharedPreferences is loading, just show a CircularProgress indicator in the Center
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } //else
        },
      ),*/   )
    );
    
  }
  }



