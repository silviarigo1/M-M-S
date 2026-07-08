// This widget is used to display the energy level of the patient in the form of batteries. 
// For is realization two instances variables are needed: livelloEnergia and livelloMassimo. The first one is the current energy level of the patient, 
// while the second one is the maximum energy level of the patient. 
// The actual visualization can be seen in the homepage screen.


import 'package:flutter/material.dart';

class WidgetEnergia extends StatelessWidget {

  final int livelloEnergia;
  final int livelloMassimo; 

  const WidgetEnergia({
    super.key, 
    required this.livelloEnergia,
    required this.livelloMassimo,
  }) : assert(livelloEnergia >= 0 && livelloEnergia <= livelloMassimo, 'L\'energia deve essere compresa tra 0 e $livelloMassimo');

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(livelloMassimo, (index) {
        
        final bool isCarica = index < livelloEnergia;

        return Expanded(
          child: Padding(
            
            padding: const EdgeInsets.symmetric(horizontal: 2.0), 
            child: Image.asset(
              
              isCarica
                  ? 'lib/images/carica.png' 
                  : 'lib/images/scarica.png',
                  

              fit: BoxFit.contain, 
            ),
          ),
        );
      }),
    );
  }
}