// This is the account page of the app, where the user can see a recap of some of the information he/she has given 
// in the onboarding page. Precisely, the user can see his/her name, surname, date of birth and sex.
// Here the user can also edit this information and save them permanently in the shared preferences.


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  AccountState createState() => AccountState();
}

class AccountState extends State<Account> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String? _selectedGender;
  final sharedPreferences = SharedPreferences.getInstance();
  
  @override

  void initState() {
    super.initState();
    _loadUserData(); 
  }

  Future<void> _loadUserData() async {
    final sp = await SharedPreferences.getInstance();
    String? savedGender = sp.getString('Gender');
    List<String> allowedGenders = ['M', 'F', 'Other'];

    setState(() {
      
      _nameController.text = sp.getString('Name') ?? '';
      _surnameController.text = sp.getString('Surname') ?? '';
      _dateController.text = sp.getString('Date') ?? '';
      if (allowedGenders.contains(savedGender)) {
      _selectedGender = savedGender;
        } else {
          _selectedGender = null; 
        }
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

                TextFormField(controller: _nameController, 
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r"[a-zA-ZàèìòùÀÈÌÒÙáéíóúÁÉÍÓÚùûüÿÝ\s']")),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                decoration: InputDecoration(labelText: "Name", border: OutlineInputBorder())),

                const SizedBox(height: 15,),
                            
                TextFormField(controller: _surnameController, 
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r"[a-zA-ZàèìòùÀÈÌÒÙáéíóúÁÉÍÓÚùûüÿÝ\s']")),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your surname';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: "Surname", border: OutlineInputBorder())),

                const SizedBox(height: 15,),

                TextFormField(controller: _dateController, readOnly: true,
                        decoration: const InputDecoration(labelText: 'Date of birth', border: OutlineInputBorder()),
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2002),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            setState(() {
                              _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
                            });
                          }
                        }, 
                  ),

              const SizedBox(height: 15,),
                DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Sex', border: OutlineInputBorder()),
                      initialValue: _selectedGender,
                      items: ['M', 'F', 'Other'].map((gender) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => _selectedGender = value),
                    ),
              
        const SizedBox(height: 20),

            ElevatedButton(
              child: Text("Save"),
              onPressed: () async {
              final sharedPreferences = await SharedPreferences.getInstance();
              if (_nameController.text.isNotEmpty) {
                await sharedPreferences.setString('Name', _nameController.text);
              }
              if (_surnameController.text.isNotEmpty) {
                await sharedPreferences.setString('Surname', _surnameController.text);
              }
              if (_dateController.text.isNotEmpty) {
                await sharedPreferences.setString('Date', _dateController.text);
              }
              if (_selectedGender != null) {
                await sharedPreferences.setString('SelectedGender', _selectedGender!);
              }

              ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Well done!"),
                                  backgroundColor: Colors.green, 
                                  behavior: SnackBarBehavior.floating,),);
              Navigator.pop(context);
            })
          ]
        )
      )
    );   
  }
}


