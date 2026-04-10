import 'package:flutter/material.dart';

import './HomePage.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  static const routename = 'LoginPage';
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print('${LoginPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(LoginPage.routename),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: userController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Username',
                hintText: 'Enter your username',
              ),),

              const SizedBox(
                height: 20,
              ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Password',
                hintText: 'Enter your password',
              ),),
            ElevatedButton(
              child: Text('Login'),
              onPressed: () {
                if (userController.text == 'bug@expert.com' && passwordController.text == '5TrNgP5Wd') {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => HomePage())));
                } else {
                  // If incorrect, show a SnackBar with an error message
                  ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(const SnackBar(
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(8),
                    duration: Duration(seconds: 2),
                    content:
                        Text("Wrong credentials")));
                  }
              },
            ),
          ], 
        ),
      ),
    );
  }
                  
} //build

