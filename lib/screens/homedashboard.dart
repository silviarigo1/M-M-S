//This is the home dashboard of the app, where the user can see the main features of the app and navigate to other pages.
//There is a dropdown menu that allows the user to choose the city of the trip, and a row of circles that show the user's steps and tiredness level.
//There is also a battery widget that shows the user's energy level, which is calculated based on the tiredness level.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mms_app/models/places.dart';
import 'package:mms_app/models/swipe.dart';
import 'package:mms_app/providers/data_provider.dart';
import 'package:mms_app/utils/impact.dart';
import 'package:mms_app/screens/options.dart';
import 'package:mms_app/widgets/batteries.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  String? selectedCity;
  final impact = Impact();

  @override
  Widget build(BuildContext context) {
    
  return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
        child: Consumer<DataProvider>(
          builder: (context, dataProvider, child) {
          if (dataProvider.stepsTotal == 0 && dataProvider.sleepHours == 0.0) {
              return const Center(child: CircularProgressIndicator());
            }  
            /*
            final double currentSteps = dataProvider.stepsTotal.toDouble();
            final double currentTiredness = dataProvider.tiredness;
            final double currentEnergy = 1 - currentTiredness;

            int currentPile;
            if (currentEnergy > 0.9) {
              currentPile = 10;
            } else if (currentEnergy < 0.15) {
              currentPile = 1;
            } else {
              currentPile = (currentEnergy / 0.1).round();
            }
        Provider.of<DataProvider>(context, listen: false).saveBattery(currentPile);*/
        
        double currentSteps = dataProvider.stepsTotal.toDouble();
        
        int currentPile = dataProvider.currentBattery;
        return Column(
          children: [
            const SizedBox(height: 15),
            //Hello User
            Align(
              alignment: Alignment.centerLeft,
              child: FutureBuilder(
                future: SharedPreferences.getInstance(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final sharedPreferences = snapshot.data!;
                    if (sharedPreferences.getString('Name') != null) {
                      return Row(
                        children: [
                          Image.asset("lib/images/mms.png", width: 45, height: 45),
                          Text(
                        'Hello ${sharedPreferences.getString('Name')}',
                        style: const TextStyle(
                          fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                )]);
                    } else {
                      return Row( 
                        children: [
                          Image.asset("lib/images/mms.png", width: 45, height: 45),
                          Text(
                            'Hello user',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      )]);
                    }
                  }
                  else {
                    return Row( 
                        children: [
                          Image.asset("lib/images/mms.png", width: 45, height: 45),
                          Text(
                            'Hello user',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      )]);
                  }
              }
            ),
            ),
            const SizedBox(height: 35),
            // Dropdown menu for choosing the city and help icon
            SizedBox(
              width: double.infinity,
              height: 70,
              child: Row(
                children: [
                  // 1. Compensatore a sinistra: serve a bilanciare l'ingombro dell'icona a destra
                  // così il dropdown rimane matematicamente al centro dello schermo.
                  const Expanded(
                    child: SizedBox.shrink(),
                  ),

                  // 2. Il tuo dropdown originale (mantiene la sua dimensione al centro)
                  DropdownButton2<String>(
                    isExpanded: true,
                    buttonStyleData: ButtonStyleData(
                      height: 70,
                      width: 220, // La larghezza fissa che hai scelto
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.lightGreen,
                      ),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                      ),
                    ),
                    hint: const Center(
                      child: Text(
                        'Choose the city',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    items: Places.cities.map<DropdownItem<String>>((String item) => DropdownItem<String>(
                      value: item,
                      child: Center(child: Text(item)),
                    )).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        int index = Places.cities.indexOf(value);
                        Provider.of<ResultSwipe>(context, listen: false).setSelectedIndexCity(index);
                        setState(() {
                          selectedCity = value;
                          Provider.of<ResultSwipe>(context, listen: false).setSelectedCity(selectedCity!);
                        });
                        Future.microtask(() {
                          if (context.mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Options())
                            );
                            Provider.of<ResultSwipe>(context, listen: false).clearSwipes();
                          }
                        });
                      }
                    },
                  ),

                  // 3. Spazio fluido a destra: prende TUTTO lo spazio rimanente fino al margine destro
                  // e posiziona l'icona esattamente al centro di questo spazio vuoto.
                  Expanded(
                    child: Center(
                      child: IconButton(
                        icon: const Icon(Icons.help_outline, color: Colors.grey),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text("Choose your destination!"),
                              content: const Text("Click on 'Choose City' to select your trip destination!\n\n"
                                  "Afterwards, you can customize your trip by picking your favorite attractions; "
                                  "swipe right to add an attraction you like, and left to skip it!\n\n"
                                  "We'll take care of the rest. Have a great trip!"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Close", style: TextStyle(color: Colors.lightGreen)),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
                  
            //Steps and tiredness indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Step indicator 
                Column(
                  children: [
                    const Text("Steps", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    FutureBuilder( future: SharedPreferences.getInstance(),
                    builder: (context, snapshot) {
                      int stepGoal = 10000;
                      if (snapshot.hasData) {
                        final sharedPreferences = snapshot.data!;
                        stepGoal = sharedPreferences.getInt('StepsAim') ?? 10000;
                      }
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: CircularProgressIndicator(
                                value: (stepGoal > 0) ? (currentSteps / stepGoal) : 0,
                                strokeWidth: 15,
                                backgroundColor: Colors.grey.withValues(alpha: 0.3),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color.lerp(const Color.fromARGB(255, 33, 243, 79), Colors.green, (currentSteps / stepGoal).clamp(0.0, 1.0)) ?? Colors.blue,
                                ),
                                strokeCap: StrokeCap.round,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("${currentSteps.round()}",
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                Text("${stepGoal.toInt()}",
                                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                          ],
                        );
                    },
                    ),
                  ],
                ),

                //Sleep Quality indicator
                Column(
                  children: [
                    const Text("Sleep Quality", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: CircularProgressIndicator(
                            // ignore: deprecated_member_use
                            value: dataProvider.punteggioFinale / 100,
                            strokeWidth: 15,
                            backgroundColor: Colors.grey.withValues(alpha: 0.3),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color.lerp(const Color.fromARGB(255, 91, 76, 175), Colors.red, dataProvider.punteggioFinale / 100) ?? Colors.green,
                            ),
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                        Text(
                          "${(dataProvider.punteggioFinale).toInt()}%",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
          ],
        ),
        const SizedBox(height: 50),
            
        Column(
          children: [
            Text("USER BATTERY:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            WidgetEnergia(livelloEnergia: currentPile, livelloMassimo: 10),
            ],
          ),
      ],
    );
          }
    )
          
  ),
);}  
  }
  