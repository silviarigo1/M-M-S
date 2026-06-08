import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Aims extends StatefulWidget {
  const Aims({super.key});

  @override
  AimsState createState() => AimsState();
}

class AimsState extends State<Aims> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _stepsAimController = TextEditingController();
  final sharedPreferences = SharedPreferences.getInstance();

@override
  void initState() {
    super.initState();
    _loadStepsAim(); // Carica i dati salvati quando apri la pagina
  }

  Future<void> _loadStepsAim() async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      _stepsAimController.text = sp.getInt('StepsAim')?.toString() ?? '';
    });
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
      body: Form(
        key: _formKey, // Colleghiamo la chiave al Form
        child:  SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
                        controller: _stepsAimController,
                        decoration: InputDecoration(labelText: 'Steps Aim', border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter steps aim';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Invalid format';
                          }
                          return null;
                        },
                      ),
                        
            SizedBox(height: 20),
            ElevatedButton(
             child: Text("Save"),
              onPressed: () async {
              if (_formKey.currentState!.validate()) {
              final sharedPreferences = await SharedPreferences.getInstance();
              if (_stepsAimController.text.isNotEmpty) {
                await sharedPreferences.setInt('StepsAim', int.parse(_stepsAimController.text));
              }
              ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Well done!"),
                                  backgroundColor: Colors.green, 
                                  behavior: SnackBarBehavior.floating,),);
              Navigator.pop(context);
            };}
            )
          ],
       ))));// Fine AppBar

    }

}

