import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AccountProvider extends ChangeNotifier {
  String _nome = "Name";
  String _cognome = "Surname";
  String _email = "";
  String _nickname = "Your Nickname";

  // Getter
  String get nome => _nome;
  String get cognome => _cognome;
  String get email => _email;
  String get nickname => _nickname;

  // Metodo per aggiornare tutto in una volta
  void updateAccount(String n, String c, String e, String nick) {
    _nome = n;
    _cognome = c;
    _email = e;
    _nickname = nick;
    notifyListeners(); // Questo avvisa tutte le pagine di aggiornarsi!
  }
}

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
  
@override
void initState() {
  super.initState();
  // Inizializziamo i controller con i valori attuali del Provider
  final acc = Provider.of<AccountProvider>(context, listen: false);
  _nameController.text = acc.nome;
  _surnameController.text = acc.cognome;
  _emailController.text = acc.email;
  _nicknameController.text = acc.nickname;
}



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
            TextField(controller: _nameController, decoration: InputDecoration(labelText: "Name")),
            TextField(controller: _surnameController, decoration: InputDecoration(labelText: "Surname")),
            TextField(controller: _emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: _nicknameController, decoration: InputDecoration(labelText: "Nickname")),
            
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