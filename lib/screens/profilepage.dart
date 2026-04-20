import 'package:flutter/material.dart';
import 'package:mms_app/screens/accountpage.dart';
import 'package:mms_app/screens/login.dart';
import 'package:profile_view/profile_view.dart';


class Profile extends StatelessWidget {
  Profile({super.key});

  //final TextEditingController _nameController = TextEditingController();
  //final TextEditingController _surnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
      body: SafeArea(
        
        child: Column(children: [

        SizedBox(height: 20,),
        
        Column( children: [ProfileView(
          image: AssetImage("lib/images/smile.png") ,
          fullscreenOnEnlarge: true,
          showCloseButton: true,
          enableZoom: true,
          enableDoubleTapZoom: true, 
        ),
        Text("Nome Cognome")
        ],),
        

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
       
    ),);
  }
}
