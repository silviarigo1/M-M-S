import 'package:flutter/material.dart';

class WidgetEnergia extends StatelessWidget {
  final int livelloEnergia; // Valore da 0 a 10

  // SINTASSI CORRETTA: Usiamo il super.key moderno di Dart 3
  const WidgetEnergia({
    super.key, 
    required this.livelloEnergia,
  }) : assert(livelloEnergia >= 0 && livelloEnergia <= 10, 'L\'energia deve essere compresa tra 0 e 10');

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(10, (index) {
        // Identifica se la batteria in questa posizione deve essere carica o scarica
        final bool isCarica = index < livelloEnergia;

        return Expanded(
          child: Padding(
            // Un piccolissimo padding laterale per non far attaccare le batterie tra loro
            padding: const EdgeInsets.symmetric(horizontal: 2.0), 
            child: Image.asset(
              
              isCarica
                  ? 'lib/images/carica.png' 
                  : 'lib/images/scarica.png',
                  
              // fit: BoxFit.contain fa in modo che l'immagine si rimpicciolisca 
              // proporzionalmente per stare dentro lo spazio dell'Expanded senza deformarsi
              fit: BoxFit.contain, 
            ),
          ),
        );
      }),
    );
  }
}