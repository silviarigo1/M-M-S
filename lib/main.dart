//This is the main file of the app, where the app is initialized and the first screen is called. 
//It also contains the main widget of the app, which is a MaterialApp with a MultiProvider as home. 
//The MultiProvider allows to use multiple providers in the app, in this case we have a ResultSwipe provider and 
//a DataProvider provider. 

import 'package:flutter/material.dart';
import 'package:mms_app/models/swipe.dart';
import 'package:mms_app/providers/data_provider.dart';
import 'package:mms_app/screens/splash.dart';
import 'package:provider/provider.dart';
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
          )
    );
  }
  }



