import 'package:flutter/material.dart';
import 'package:mms_app/models/places.dart';
import 'package:mms_app/screens/home.dart';
import 'package:provider/provider.dart';
import '../models/swipe.dart';

class Choices extends StatefulWidget {
  const Choices({Key? key}) : super(key: key);

  static const routename = "Choices";

  @override
  State<Choices> createState() => _ChoicesState();
}

class _ChoicesState extends State<Choices> {
  @override
  Widget build(BuildContext context) {
    print('${Choices.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trip recap',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ), 

      body: Consumer<ResultSwipe>(
        builder: (context, number, child) {
          return number.swipes.isEmpty
              ? const Center(child: 
                Text(
                  'No destinations selected',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)))
                
              : ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: number.swipes.length,
                  itemBuilder: (context, destIndex) {
                    int indexOriginale = number.savedIndices[destIndex];
                    String destinations = Places.mapDest["title"]![indexOriginale];

                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        leading: const Icon(
                          Icons.pin_drop,
                          color: Colors.lightGreen,
                        ),
                        title: Text(
                          destinations,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_rounded,
                            color: Color.fromARGB(255, 93, 92, 92),
                          ),
                          onPressed: () {
                            
                            setState(() {number.trashDest(destIndex);});
                            ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Destination removed!")),);
                          }
                          
                        ),
                      ),
                    ); 
                    
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 28),
                      child: Container(
                        width: 2,
                        height: 30,
                        color: Colors.lightGreen.withValues(alpha: 0.4),
                      ),
                    ); 
                  },
                ); 
        }, 
      ), 
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children:[
          FloatingActionButton(
            mini: true,
        
        onPressed: () {
    _showDestinationsPopup(context); // Chiamata alla funzione che crea il popup
  },
        backgroundColor: Colors.lightGreen,
        child: const Icon(
          Icons.add,
          color: Colors.white,),
        ),
        const SizedBox(height: 20),
        FloatingActionButton(
        onPressed: () {
          if (Provider.of<ResultSwipe>(context, listen: false).savedIndices.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please select at least one destination!"),
                      backgroundColor: Colors.red, 
                      behavior: SnackBarBehavior.floating,),
            );
             // Non procedere se non ci sono destinazioni
          }
          Provider.of<ResultSwipe>(context, listen: false).savePlaces();
          
          Navigator.pushAndRemoveUntil( context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Trip saved!"),
                    backgroundColor: Colors.green, 
                    behavior: SnackBarBehavior.floating,),
          );
        },
        backgroundColor: Colors.lightGreen,
        child: const Icon(
          Icons.save,
          color: Colors.white,),
        ),
        ],
      ),
      
    ); 
  } 
} 


void _showDestinationsPopup(BuildContext context) {
  final resultSwipe = Provider.of<ResultSwipe>(context, listen: false);

  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text("Destination not selected"),
        content: SizedBox(
          width: double.maxFinite,
          // Usiamo nonSavedIndices per la logica del popup
          child: resultSwipe.nonSavedIndices.isEmpty
              ? const Text("You selected all destinations!")
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: resultSwipe.nonSavedIndices.length,
                  itemBuilder: (context2, index) {
                    // Recuperiamo l'indice originale dalla lista dei non salvati
                    int indexOriginale = resultSwipe.nonSavedIndices[index];
                    String nomePosto = Places.mapDest["title"]![indexOriginale];

                    return ListTile(
                      leading: const Icon(Icons.pin_drop, color: Colors.lightGreen),
                      title: Text(nomePosto),
                      subtitle: const Text("Tap to add"), // Opzionale
                      onTap: () {
                        
                        resultSwipe.saveIndex(indexOriginale);
    
   
                        resultSwipe.saveSwipe(Container(
                          child: Text(nomePosto),
                        ));

                        
                        Navigator.pop(dialogContext);

                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("$nomePosto added!"),
                                  backgroundColor: Colors.green, 
                                  behavior: SnackBarBehavior.floating,),);
                      },
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Close", style: TextStyle(color: Colors.lightGreen)),
          ),
        ],
      );
    },
  );
}