import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';





class Account extends StatefulWidget {
  const Account({super.key});

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final sharedPreferences = SharedPreferences.getInstance();
  
  
  
  
  @override
    Widget build(BuildContext context) {
     return   Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Account',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: "Name", 
                          hintText: 'Enter your name',)),
            TextField(controller: _surnameController, decoration: InputDecoration(labelText: "Surname", 
                          hintText: 'Enter your surname',)),
            TextField(controller: _emailController, decoration: InputDecoration(labelText: "Email", 
                          hintText: 'Enter your email',)),
            TextField(controller: _nicknameController, decoration: InputDecoration(labelText: "Nickname", 
                          hintText: 'Enter your nickname',)),

            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Save"),
              onPressed: () async {
              final sharedPreferences = await SharedPreferences.getInstance();
              await sharedPreferences.setString('Name', _nameController.text);
              await sharedPreferences.setString('Surname', _surnameController.text);
              await sharedPreferences.setString('Email', _emailController.text);
              await sharedPreferences.setString('Nickname', _nicknameController.text);
              
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Well done!")),
            );
              },
            ),
    
          ],
       )));// Fine AppBar

    }
}