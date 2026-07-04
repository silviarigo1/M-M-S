//This is the onboarding page of the app, where the user can insert some personal data that 
//will be used to personalize the app experience. The data are stored in SharedPreferences and 
//can be edited later in the settings page. The user can also skip this page and go directly to the home page.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mms_app/providers/data_provider.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
   final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String? _selectedGender;
  final TextEditingController _stepsAimController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }
    Future<void> _loadSavedData() async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = sp.getString('Name') ?? '';
      _surnameController.text = sp.getString('Surname') ?? '';
      _dateController.text = sp.getString('Dob') ?? '';
      _selectedGender = sp.getString('Gender');
      _stepsAimController.text = sp.getInt('StepsAim')?.toString() ?? '';
      _ageController.text = sp.getInt('Age')?.toString() ?? '';
    });
  }
    Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2002),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }
    Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final sp = await SharedPreferences.getInstance();
      int age = DateTime.now().year - DateFormat('dd/MM/yyyy').parse(_dateController.text).year;
      await sp.setInt('Age', age);
      await sp.setString('Name', _nameController.text);
      await sp.setString('Surname', _surnameController.text);
      await sp.setString('Gender', _selectedGender!);
      await sp.setString('Dob', _dateController.text);
      await sp.setInt('StepsAim', int.parse(_stepsAimController.text));
      await sp.setBool('onboarding_completed', true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data saved successfully!'),
          backgroundColor: Colors.green, 
          behavior: SnackBarBehavior.floating,),
      );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider<DataProvider>(
              create: (context) => DataProvider(),
              child: const HomeScreen(), 
            ),
          ),
        );
    }
  }
  Future<void> _setOnboardingCompleted() async {
    final sp = await SharedPreferences.getInstance();
    await sp.setBool('onboarding_completed', true);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [Padding(
            padding: const EdgeInsets.all(16.0),
            child: 
            SingleChildScrollView(
              child: Column( children: [              
                Image.asset(
                  'lib/images/logonuovo.jpeg',
                  alignment: Alignment.center,
                  width: 80, // Larghezza desiderata
                  height: 80,
                ),
                const SizedBox(
                      height: 30,
                    ),  
                const Text(
                  'Let\'s know you better',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
                ),
                const SizedBox(
                  height: 25,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children:[
                      TextFormField(
                        controller: _nameController,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r"[a-zA-ZàèìòùÀÈÌÒÙáéíóúÁÉÍÓÚùûüÿÝ\s']")),
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Name',
                          hintText: 'Enter your name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _surnameController,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r"[a-zA-ZàèìòùÀÈÌÒÙáéíóúÁÉÍÓÚùûüÿÝ\s']")),
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Surname',
                          hintText: 'Enter your surname',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your surname';
                          } 
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(labelText: 'Sex', border: OutlineInputBorder()),
                        value: _selectedGender,
                        items: ['M', 'F', 'Other'].map((gender){
                          return DropdownMenuItem<String>(
                            value: gender,
                            child: Text(gender),
                          );
                        }).toList(),
                        onChanged: (value) => setState(() => _selectedGender = value),
                        validator: (value) => value == null ? 'Choose gender' : null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _dateController,
                        readOnly: true,
                        decoration: InputDecoration(labelText: 'Date of birth', border: OutlineInputBorder()),
                        onTap: () => _selectDate(context),
                        validator: (value) => value == null || value.isEmpty ? 'Pick a date' : null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                       TextFormField(
                        controller: _stepsAimController,
                        decoration: InputDecoration(labelText: 'Steps Aim', border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter steps aim';
                          }
                          if (int.tryParse(value) == null || int.parse(value) <= 0) {
                            return 'Invalid format';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text('Save'),

                        style: ElevatedButton.styleFrom(
                        minimumSize: const Size(50, 50), 
                        side: const BorderSide(
                        color: Colors.lightGreen, 
                        width: 2.0,               
                      ),),   
                      ),
                    ]),
                 ),
                ],
              ),                      
            ),
                  ),
            Positioned(
              bottom: 16,
              right: 16,
              child: TextButton(
                onPressed: () async {
                  await _setOnboardingCompleted();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider<DataProvider>(
                        create: (context) => DataProvider(),
                        child: const HomeScreen(), 
                      ),
                    ),
                  );
                },
                child: Text(
                  'Skip',
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),    
                  ),]
        ),
      ),);
  }
}