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
  State<MetaCardItem> createState() => _MetaCardItemState();
}

class _MetaCardItemState extends State<MetaCardItem> {
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
        left: widget.isPari ? 10 : 80, 
        right: widget.isPari ? 80 : 10,
      ),
      child: Opacity(
        // Se è completata diventa trasparente (0.4), altrimenti è normale (1.0)
        opacity: _isCompleted ? 0.4 : 1.0, 
        child: Card(
          elevation: _isCompleted ? 1 : 5, // Abbassa l'ombra se completato
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
          child: ListTile(
            leading: Image.asset(
              Places.mapDest["image"]![widget.indexDellaMeta],
              width: 70,
              height: 70,
              fit: BoxFit.contain,
            ),
            title: Text(
              "${Places.mapDest["title"]![widget.indexDellaMeta]}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                // Sbarra il testo se l'obiettivo è completato (opzionale)
                decoration: _isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                color: _isCompleted ? Colors.grey : Colors.black,
              ),
            ),
            subtitle: Row(
                  mainAxisSize: MainAxisSize.min,   
                  children: [ 
                    // Testo dinamico
                    Text(Places.batt[widget.indexDellaMeta] == -1 
                      ? '+1' 
                      : "Cost: ${Places.batt[widget.indexDellaMeta]}"
                    ),
                    // Icona con colore dinamico
                    Icon(
                      Icons.battery_charging_full_outlined, 
                      color: Places.batt[widget.indexDellaMeta] == -1
                        ? const Color.fromARGB(255, 82, 198, 40)  // Verde
                        : const Color.fromARGB(255, 198, 40, 40), // Rosso
                    ),
                  ],
                ),
            trailing: Checkbox(
              value: _isCompleted,
              activeColor: Colors.lightGreen,
              onChanged: (bool? value) async {
              final newValue = value ?? false;
              
              final sp = await SharedPreferences.getInstance();
              await sp.setBool('meta_${widget.indexDellaMeta}', newValue);
              setState(() {
                  _isCompleted = value ?? false; // Aggiorna lo stato di questa specifica card
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}