//This is the profile page where the user can see his/her profile picture, name and surname.
//You can also navigate to the account page where you can change your personal data and to the aims page 
//where you can change your steps aim.

import 'package:flutter/material.dart';
import 'package:mms_app/screens/accountpage.dart';
import 'package:mms_app/screens/aim.dart';
import 'package:mms_app/screens/login.dart';
import 'package:profile_view/profile_view.dart';

import 'package:shared_preferences/shared_preferences.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

@override 
State<Profile> createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
        const SizedBox(height:20),
        Row( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ProfileView(
          image: AssetImage("lib/images/smile.png") ,
          fullscreenOnEnlarge: true,
          showCloseButton: true,
          enableZoom: true,
          enableDoubleTapZoom: true, 
        ),
        
         GestureDetector(
            onTap: () => _mostraOpzioniFoto(context), // Funzione per il pop-up
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.grey, // Colore cerchio
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit, // Icona matita
                color: Colors.white,
                size: 10,
              ),
            ),
          ),
        
      ],
    ),
            const SizedBox(height: 10),
            FutureBuilder(
              future: SharedPreferences.getInstance(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final sharedPreferences = snapshot.data!;
                  String name = sharedPreferences.getString('Name') ?? 'Name';
                  String surname = sharedPreferences.getString('Surname') ?? 'Surname';

                  return Text(
                        "$name $surname",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      );
                } else {
                  return const CircularProgressIndicator(); 
                }
              },
            ),
          Padding(
            padding:
                EdgeInsets.only(left: 12.0, right: 12.0, top: 60, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                
              Card(
                elevation: 5,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        onTap: () async {
                            await Navigator.push(context, MaterialPageRoute(builder: (context) =>  Account()),
                            );
                            setState((){});
                          },
                        leading: const Icon(
                          Icons.person,
                          color: Colors.lightGreen,
                        ),
                        title: Text(
                          "Account",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    
            ),
              const SizedBox(
                height: 20,
              ),                     
            Card(
              elevation: 5,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  Aims()),
                            );
                          },
                        leading: const Icon(
                          Icons.flag,
                          color: Colors.lightGreen,
                        ),
                        title: Text(
                          "Aims/Goals",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
            ),
              const SizedBox(
                height: 20,
              ),
              
              SizedBox(
                height: 20,
              ),
              // Log out button
              Align(
                alignment: Alignment.center,
                child: TextButton.icon(
                  icon: const Icon(Icons.logout, color: Colors.grey),
                  label: const Text("Logout", style: TextStyle(color: Colors.grey)),
                  onPressed: () {
 
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Logout"),
                        content: const Text("Sei sicuro di voler uscire?"),
                        actions: [
                          TextButton(
                            child: const Text("Annulla"),
                            onPressed: () {
                              Navigator.of(context).pop(); 
                            },
                          ),

                          TextButton(
                            child: const Text("Logout", style: TextStyle(color: Colors.red)),
                            onPressed: () async {
                              // Logica originale spostata qui
                              final sharedPreferences = await SharedPreferences.getInstance();
                              await sharedPreferences.remove('isUserLogged');
                              if (context.mounted) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginPage()),
                                  (route) => false,
                                );
                              }
                            }, // onPressed del tasto Logout
                          ),
                        ],
                      );
                    },
                  );
                }, 
                ),
          ),
            ])
        ),
        ],
      ),
      ),
    );    
  }
}

// Function to show the bottom sheet with options to upload or delete the profile picture 

void _mostraOpzioniFoto(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Wrap( // Il Wrap si adatta all'altezza del contenuto
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Profile photo",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library, color: Colors.blue),
            title: const Text("Upload new photo"),
            onTap: () {
              // Qui aggiungerai la logica per scegliere la foto
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text("Delete photo", style: TextStyle(color: Colors.red)),
            onTap: () {
              // Qui aggiungerai la logica per resettare l'immagine
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 20),
        ],
      );
    },
  );
}