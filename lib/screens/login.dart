import 'package:flutter/material.dart';
import 'package:mms_app/providers/data_provider.dart';
import 'package:mms_app/screens/home.dart';
import 'package:mms_app/screens/onboarding.dart';
import 'package:mms_app/utils/impact.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  static const routename = 'M&MS Trip';
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Impact impact = Impact();
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
                'lib/images/logonuovo.jpeg',
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
                prefixIcon: Icon(Icons.person),
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
                prefixIcon: Icon(Icons.lock),
              ),),
              ],)       
              ),
            const SizedBox(
                height: 20,
              ),
            ElevatedButton(
              
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50), 
                side: const BorderSide(
                color: Colors.lightGreen, // Colore del bordino verde chiaro
                width: 2.0,               // Spessore del bordino in pixel
              ),
              
              ),
              
              child: Text('Login'),
              onPressed: () async {
                    // check if credentials are correct
                    final result = await impact.getAndStoreTokens(userController.text, passwordController.text);
                    // If correct, store the username and password in SharedPreferences
                    // and navigate to the Exposure screen (pushReplacement to remove the login screen from the stack)
                    if (result == 200) {
                      final sp = await SharedPreferences.getInstance();
                      await sp.setBool('isUserLogged', true);
                      await sp.setString('username', userController.text);
                      await sp.setString('password', passwordController.text);
                      final onboarding_completed = await sp.getBool('onboarding_completed');
                      if(onboarding_completed == null || onboarding_completed == false){
                        Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider<DataProvider>(
                            create: (context) => DataProvider(),
                            child: Onboarding(),
                          ),
                        ),
                      );
                      }
                      else{
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider<DataProvider>(
                            create: (context) => DataProvider(),
                            child: HomeScreen(),
                            
                          ),
                          ),
                        );
                      }
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

