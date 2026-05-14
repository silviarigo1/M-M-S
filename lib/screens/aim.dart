import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Aims extends StatefulWidget {
  const Aims({super.key});

  @override
  _AimsState createState() => _AimsState();
}

class _AimsState extends State<Aims> {

  final TextEditingController _stepsAimController = TextEditingController();
  final sharedPreferences = SharedPreferences.getInstance();

@override
  void initState() {
    super.initState();
    _loadSteps(); // Carica i dati salvati quando apri la pagina
  }

  Future<void> _loadSteps() async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      _stepsAimController.text = sp.getInt('StepsAim')?.toString() ?? '';
    });
  }

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
              controller: _stepsAimController, 
              keyboardType: TextInputType.number, // Tastierino numerico
              decoration: const InputDecoration(labelText: "Daily step goal"),
            ),
                        
            SizedBox(height: 20),
            ElevatedButton(
             child: Text("Save"),
              onPressed: () async {
              final sharedPreferences = await SharedPreferences.getInstance();
              if (_stepsAimController.text.isNotEmpty) {
                await sharedPreferences.setInt('StepsAim', int.parse(_stepsAimController.text));
              }
               ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Well done!")),
              );
            },)
          ],
       )));// Fine AppBar

    }

}

