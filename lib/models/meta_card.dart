import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/places.dart';

// --- WIDGET CARD AUTONOMO (Gestisce opacità e checkbox di ogni singola riga) ---
class MetaCardItem extends StatefulWidget {
  final int indexDellaMeta;
  final bool isPari;

  const MetaCardItem({
    super.key, 
    required this.indexDellaMeta, 
    required this.isPari,
  });

  @override
  State<MetaCardItem> createState() => MetaCardItemState();
}

class MetaCardItemState extends State<MetaCardItem> {
  // Ogni riga memorizza qui dentro se è stata cliccata o meno
  bool _isCompleted = false; 

  @override
  void initState() {
    super.initState();
    _loadCompletionStatus();
  }

  Future<void> _loadCompletionStatus() async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      _isCompleted = sp.getBool('meta_${widget.indexDellaMeta}') ?? false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: widget.isPari ? 10 : 60, 
        right: widget.isPari ? 60 : 10,
        top: 6,
        bottom: 6,
      ),
      child: Opacity(
        
        opacity: _isCompleted ? 0.4 : 1.0, 
        child: Card(
          elevation: _isCompleted ? 1 : 4, // Abbassa l'ombra se completato
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
                    Places.mapDest["image"]![widget.indexDellaMeta],
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
                        "${Places.mapDest["title"]![widget.indexDellaMeta]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          // Sbarra il testo se l'obiettivo è completato
                          decoration: _isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                          color: _isCompleted ? Colors.grey : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.min,   
                        children: [ 
                          // Testo dinamico
                          Text(Places.batt[widget.indexDellaMeta] == -1 
                            ? '+1' 
                            : "Cost: ${Places.batt[widget.indexDellaMeta]}"
                          ),
                          const SizedBox(width: 2),
                          // Icona con colore dinamico
                          Icon(
                            Icons.battery_charging_full_outlined, 
                            size: 18,
                            color: Places.batt[widget.indexDellaMeta] == -1
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
                  value: _isCompleted,
                  activeColor: Colors.lightGreen,
                  onChanged: (bool? value) async {
                    final newValue = value ?? false;
                    
                    final sp = await SharedPreferences.getInstance();
                    await sp.setBool('meta_${widget.indexDellaMeta}', newValue);
                    setState(() {
                      _isCompleted = newValue; // Aggiorna lo stato di questa specifica card
                    });
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