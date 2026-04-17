import 'package:flutter/material.dart';

import './home.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  static const routename = 'M&MS Trip';
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print('${LoginPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(LoginPage.routename, style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:100.0),

              child: Column(children: [
              
              Image.asset(
                'lib/images/impronta.png',
                width: 80, // Larghezza desiderata
                height: 80, // Altezza desiderata
                fit: BoxFit.contain, // Determina come l'immagine si adatta allo spazio
              ),

              const SizedBox(
                height: 40,
              ),

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

              ],)
              
              ),
            
            const SizedBox(
                height: 20,
              ),

            ElevatedButton(
              child: Text('Login'),
              onPressed: () {
                if (userController.text == 'mms' && passwordController.text == '031828') {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => HomeScreen())));
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

