import 'package:flutter/material.dart';


class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  // 1. Definiamo i controller (come quelli della tua immagine)
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  // 2. Variabili per "salvare" e visualizzare i dati nella schermata
  String nomeSalvato = "";
  String cognomeSalvato = "";
  String emailSalvata = "";
  String nicknameSalvato = "Il tuo Nickname"; // Questo comparirà sotto l'immagine

  void _salvaDati() {
    setState(() {
      // Aggiorniamo le variabili con il testo attuale dei controller
      nomeSalvato = _nameController.text;
      cognomeSalvato = _surnameController.text;
      emailSalvata = _emailController.text;
      nicknameSalvato = _nicknameController.text;
    });
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
            TextField(controller: _nameController, decoration: InputDecoration(labelText: "Nome")),
            TextField(controller: _surnameController, decoration: InputDecoration(labelText: "Cognome")),
            TextField(controller: _emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: _nicknameController, decoration: InputDecoration(labelText: "Nickname")),
            
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _salvaDati,
              child: Text("Salva Dati"),
            ),
          ],
       )));// Fine AppBar

    }
}