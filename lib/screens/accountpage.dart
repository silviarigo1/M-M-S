import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class AccountProvider extends ChangeNotifier {
  String _nome = "Nome";
  String _cognome = "Cognome";
  String _email = "";
  String _nickname = "Il tuo Nickname";

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

void _salvaDati() {
  // Salviamo nel Provider
  Provider.of<AccountProvider>(context, listen: false).updateAccount(
    _nameController.text,
    _surnameController.text,
    _emailController.text,
    _nicknameController.text,
  );
  
  // Opzionale: torna indietro o mostra un messaggio
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Dati salvati con successo!")),
  );
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