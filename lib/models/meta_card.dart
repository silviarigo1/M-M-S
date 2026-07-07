// This file defines a MetaCardItem widget that represents a card in a list. 
// Each card displays an image, title, cost, and a checkbox to mark it as completed. 
// The card's appearance changes based on whether it is completed or not, including opacity and shadow elevation. 
// The widget uses the Provider package to manage state and read the completion status of each card. 

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import '../models/places.dart';
import '../models/swipe.dart'; 

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
    
    // This is done to show the card in different positions based on whether the index is even or odd, 
    // creating a staggered effect in the list.
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
          elevation: isCompleted ? 1 : 4, 
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              children: [

                // IMAGE
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
                // TITLE AND COST
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
                          decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                          color: isCompleted ? Colors.grey : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.min,   
                        children: [ 
                          Text(Places.batt[indexDellaMeta] == -1 
                            ? '+1' 
                            : "Cost: ${Places.batt[indexDellaMeta]}"
                          ),
                          const SizedBox(width: 2),
                          
                          // ICON WITH COLOR BASED ON BATTERY LEVEL
                          Icon(
                            Icons.battery_charging_full_outlined, 
                            size: 18,
                            color: Places.batt[indexDellaMeta] == -1
                              ? const Color.fromARGB(255, 82, 198, 40)  
                              : const Color.fromARGB(255, 198, 40, 40), 
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 8),

                // CHECKBOX 
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