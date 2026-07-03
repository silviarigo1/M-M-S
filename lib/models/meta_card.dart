import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import fondamentale per leggere lo stato
import '../models/places.dart';
import '../models/swipe.dart'; // Assicurati che il percorso del tuo ResultSwipe sia corretto

// --- WIDGET CARD AUTONOMO (Gestisce opacità e checkbox di ogni singola riga) ---
class MetaCardItem extends StatelessWidget {
  final int indexDellaMeta;
  final bool isPari;

  const MetaCardItem({
    super.key, 
    required this.indexDellaMeta, 
    required this.isPari,
  });

  @override
  Widget build(BuildContext context) {
    
    final provider = Provider.of<ResultSwipe>(context);
    
    final bool isCompleted = provider.checkedPlaces.contains(indexDellaMeta);

    return Padding(
      padding: EdgeInsets.only(
        left: isPari ? 10 : 60, 
        right: isPari ? 60 : 10,
        top: 6,
        bottom: 6,
      ),
      child: Opacity(
        opacity: isCompleted ? 0.4 : 1.0, 
        child: Card(
          elevation: isCompleted ? 1 : 4, // Abbassa l'ombra se completato
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              children: [
                // 1. IMMAGINE (Leading)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    Places.mapDest["image"]![indexDellaMeta],
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover, 
                  ),
                ),
                const SizedBox(width: 12),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${Places.mapDest["title"]![indexDellaMeta]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          // Sbarra il testo se l'obiettivo è completato
                          decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                          color: isCompleted ? Colors.grey : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.min,   
                        children: [ 
                          // Testo dinamico
                          Text(Places.batt[indexDellaMeta] == -1 
                            ? '+1' 
                            : "Cost: ${Places.batt[indexDellaMeta]}"
                          ),
                          const SizedBox(width: 2),
                          // Icona con colore dinamico
                          Icon(
                            Icons.battery_charging_full_outlined, 
                            size: 18,
                            color: Places.batt[indexDellaMeta] == -1
                              ? const Color.fromARGB(255, 82, 198, 40)  // Verde
                              : const Color.fromARGB(255, 198, 40, 40), // Rosso
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 8),

                // 3. CHECKBOX (Trailing)
                Checkbox(
                  value: isCompleted,
                  activeColor: Colors.lightGreen,
                  onChanged: (bool? value) {
                  
                    provider.tipPlaceCheck(indexDellaMeta);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}