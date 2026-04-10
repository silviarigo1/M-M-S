import 'package:flutter/material.dart';
import 'login.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routename = 'Homepage';

  @override
  Widget build(BuildContext context) {
    print('${HomePage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(HomePage.routename),
      ),
      body: Center(
        child:        
      ElevatedButton(
         onPressed : (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
          child: Text('To the login page'),
    ),
    ),);
  } //build

}