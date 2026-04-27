import 'package:flutter/material.dart';
import 'package:mms_app/models/swipe.dart';
import 'package:mms_app/screens/accountpage.dart';
import 'package:mms_app/screens/aim.dart';
import 'screens/login.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ResultSwipe(), ),
        ChangeNotifierProvider(create: (context) => AimsProvider()), 
        ChangeNotifierProvider(create: (context) => AccountProvider()), 
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Login Page',
          home: LoginPage(),    )
    );
    
  }
  }



