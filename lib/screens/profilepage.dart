import 'package:flutter/material.dart';
import 'package:mms_app/screens/accountpage.dart';
import 'package:mms_app/screens/aim.dart';
import 'package:mms_app/screens/login.dart';
import 'package:profile_view/profile_view.dart';
import 'package:provider/provider.dart';


class Profile extends StatelessWidget {
  Profile({super.key});

  //final TextEditingController _nameController = TextEditingController();
  //final TextEditingController _surnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final accountData = Provider.of<AccountProvider>(context);
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
            Text(
              accountData.nickname, 
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Se vuoi mostrare anche Nome e Cognome sotto:
            Text("${accountData.nome} ${accountData.cognome}"),
        

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
                        onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  Account()),
                            );
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
              Align(
                alignment: Alignment.center,
                child: TextButton.icon(
                  icon: const Icon(Icons.logout, color: Colors.grey),
                  label: const Text("Logout", style: TextStyle(color: Colors.grey)),
                  onPressed: () {
                    
                     Navigator.pushAndRemoveUntil( context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
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