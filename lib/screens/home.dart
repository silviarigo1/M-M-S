import 'package:flutter/material.dart';

import './LoginPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routename = 'HomePage';

  @override
  Widget build(BuildContext context) {
    print('${HomePage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(HomePage.routename),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('To the LoginPage'),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => LoginPage())));
              },
            ),
            
            
          ],
        ),
      ),
    );
  } //build

} //LoginPage
