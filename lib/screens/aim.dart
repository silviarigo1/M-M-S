import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AimsProvider extends ChangeNotifier {
  // Valori di default
  int _stepsGoal = 10000;


  // Getter per leggere i valori
  int get stepsGoal => _stepsGoal;
 

  // Metodi per modificare i valori
  void updateSteps(int newSteps) {
    _stepsGoal = newSteps;
    notifyListeners(); // Notifica la UI del cambiamento
  }
}

class Aims extends StatefulWidget {
  const Aims({super.key});

  @override
  _AimsState createState() => _AimsState();
}

class _AimsState extends State<Aims> {

  final TextEditingController _aimsController = TextEditingController();
  String aimsSalvato = "";
  void _salvaDati() {
    int? nuovoValore = int.tryParse(_aimsController.text);
    if (nuovoValore != null) {
      // Aggiorna il Provider
      Provider.of<AimsProvider>(context, listen: false).updateSteps(nuovoValore);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Obiettivo aggiornato!")),
      );
    }
  }
@override
    Widget build(BuildContext context) {
     return   Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Aims',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _aimsController, 
              keyboardType: TextInputType.number, // Tastierino numerico
              decoration: const InputDecoration(labelText: "Obiettivo passi giornalieri"),
            ),
                        
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _salvaDati,
              child: Text("Salva Dati"),
            ),
          ],
       )));// Fine AppBar

    }

}