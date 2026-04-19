import 'package:flutter/material.dart';
import './places.dart';

class TravelCard {
  List<Container> cards = [
  Container(
    margin: EdgeInsets.all(20),  
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.grey[200], 
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3), 
          blurRadius: 25,
          spreadRadius: 5,
          offset: Offset(0, 0),
        ),
      ],
    ),
  
    clipBehavior: Clip.antiAlias, 
  
    child: Column(
      children: [
        
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          color: Colors.lightGreen, 
          child: Text(
            Places.places[0],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      
        Container(
        color: Colors.grey[200],
        width: double.infinity,
        child: Image.asset(
          'lib/images/mete/CappellaScrovegni.jpg',
          height: 300, 
          fit: BoxFit.cover, 
        ),
      ),
      
    
      Expanded(
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          color: Colors.grey[300], 
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
          child: Text(
            Places.descriptions[0],
            style: TextStyle(fontSize: 16, height: 1.4),
            textAlign: TextAlign.justify,
          ),
          ),
        ),
      ),
    ],
    ),
  ),

    Container(
    margin: EdgeInsets.all(20), 
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.grey[200], 
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3), 
          blurRadius: 25,
          spreadRadius: 5,
          offset: Offset(0, 0),
        ),
      ],
    ),
  
    clipBehavior: Clip.antiAlias, 
  
    child: Column(
      children: [
        
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          color: Colors.lightGreen, 
          child: Text(
            Places.places[1],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
  ),
      
      
      Container(
        color: Colors.grey[200],
        width: double.infinity,
        child: Image.asset(
          'lib/images/mete/BasilicaAntonio.jpg',
          height: 300, 
          fit: BoxFit.cover, 
        ),
      ),
      
    
      Expanded(
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          color: Colors.grey[300], 
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
          child: Text(
            Places.descriptions[1],
            style: TextStyle(fontSize: 16, height: 1.4),
            textAlign: TextAlign.justify,
          ),
          ),
        ),
      ),
    ],
  ),
),
Container(
    margin: EdgeInsets.all(20), 
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.grey[200], 
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3), 
          blurRadius: 25,
          spreadRadius: 5,
          offset: Offset(0, 0),
        ),
      ],
    ),
  
    clipBehavior: Clip.antiAlias, 
  
    child: Column(
      children: [
        
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          color: Colors.lightGreen, 
          child: Text(
            Places.places[2],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
  ),
      
      
      Container(
        color: Colors.grey[200],
        width: double.infinity,
        child: Image.asset(
          'lib/images/mete/PratoValle.jpg',
          height: 300, 
          fit: BoxFit.cover, 
        ),
      ),
      
    
      Expanded(
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          color: Colors.grey[300], 
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
          child: Text(
            Places.descriptions[2],
            style: TextStyle(fontSize: 16, height: 1.4),
            textAlign: TextAlign.justify,
          ),
          ),
        ),
      ),
    ],
  ),
),
Container(
    margin: EdgeInsets.all(20), 
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.grey[200], 
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3), 
          blurRadius: 25,
          spreadRadius: 5,
          offset: Offset(0, 0),
        ),
      ],
    ),
  
    clipBehavior: Clip.antiAlias, 
  
    child: Column(
      children: [
        
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          color: Colors.lightGreen, 
          child: Text(
            Places.places[3],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
  ),
      
      
      Container(
        color: Colors.grey[200],
        width: double.infinity,
        child: Image.asset(
          'lib/images/mete/PalazzoRagione.jpg',
          height: 300, 
          fit: BoxFit.cover, 
        ),
      ),
      
    
      Expanded(
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          color: Colors.grey[300], 
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
          child: Text(
            Places.descriptions[3],
            style: TextStyle(fontSize: 16, height: 1.4),
            textAlign: TextAlign.justify,
          ),
          ),
        ),
      ),
    ],
  ),
),
Container(
    margin: EdgeInsets.all(20), 
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.grey[200], 
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3), 
          blurRadius: 25,
          spreadRadius: 5,
          offset: Offset(0, 0),
        ),
      ],
    ),
  
    clipBehavior: Clip.antiAlias, 
  
    child: Column(
      children: [
        
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          color: Colors.lightGreen, 
          child: Text(
            Places.places[4],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
  ),
      
      
      Container(
        color: Colors.grey[200],
        width: double.infinity,
        child: Image.asset(
          'lib/images/mete/OrtoBotanico.jpg',
          height: 300, 
          fit: BoxFit.cover, 
        ),
      ),
      
    
      Expanded(
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          color: Colors.grey[300], 
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
          child: Text(
            Places.descriptions[4],
            style: TextStyle(fontSize: 16, height: 1.4),
            textAlign: TextAlign.justify,
          ),
          ),
        ),
      ),
    ],
  ),
),
Container(
    margin: EdgeInsets.all(20), 
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.grey[200], 
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3), 
          blurRadius: 25,
          spreadRadius: 5,
          offset: Offset(0, 0),
        ),
      ],
    ),
  
    clipBehavior: Clip.antiAlias, 
  
    child: Column(
      children: [
        
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          color: Colors.lightGreen, 
          child: Text(
            Places.places[5],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
  ),
      
      
      Container(
        color: Colors.grey[200],
        width: double.infinity,
        child: Image.asset(
          'lib/images/mete/PalazzoBo.jpg',
          height: 300, 
          fit: BoxFit.cover, 
        ),
      ),
      
    
      Expanded(
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          color: Colors.grey[300], 
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
          child: Text(
            Places.descriptions[5],
            style: TextStyle(fontSize: 16, height: 1.4),
            textAlign: TextAlign.justify,
          ),
          ),
        ),
      ),
    ],
  ),
),
Container(
    margin: EdgeInsets.all(20), 
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.grey[200], 
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3), 
          blurRadius: 25,
          spreadRadius: 5,
          offset: Offset(0, 0),
        ),
      ],
    ),
  
    clipBehavior: Clip.antiAlias, 
  
    child: Column(
      children: [
        
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          color: Colors.lightGreen, 
          child: Text(
            Places.places[6],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
  ),
      
      
      Container(
        color: Colors.grey[200],
        width: double.infinity,
        child: Image.asset(
          'lib/images/mete/PiazzaFrutta.jpg',
          height: 300, 
          fit: BoxFit.cover, 
        ),
      ),
      
    
      Expanded(
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          color: Colors.grey[300], 
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
          child: Text(
            Places.descriptions[6],
            style: TextStyle(fontSize: 16, height: 1.4),
            textAlign: TextAlign.justify,
          ),
          ),
        ),
      ),
    ],
  ),
),
Container(
    margin: EdgeInsets.all(20), 
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.grey[200], 
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3), 
          blurRadius: 25,
          spreadRadius: 5,
          offset: Offset(0, 0),
        ),
      ],
    ),
  
    clipBehavior: Clip.antiAlias, 
  
    child: Column(
      children: [
        
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          color: Colors.lightGreen, 
          child: Text(
            Places.places[7],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
  ),
      
      
      Container(
        color: Colors.grey[200],
        width: double.infinity,
        child: Image.asset(
          'lib/images/mete/CaffePedrocchi.jpg',
          height: 300, 
          fit: BoxFit.cover, 
        ),
      ),
      
    
      Expanded(
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          color: Colors.grey[300], 
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
          child: Text(
            Places.descriptions[7],
            style: TextStyle(fontSize: 16, height: 1.4),
            textAlign: TextAlign.justify,
          ),
          ),
        ),
      ),
    ],
  ),
),
Container(
    margin: EdgeInsets.all(20), 
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.grey[200], 
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3), 
          blurRadius: 25,
          spreadRadius: 5,
          offset: Offset(0, 0),
        ),
      ],
    ),
  
    clipBehavior: Clip.antiAlias, 
  
    child: Column(
      children: [
        
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          color: Colors.lightGreen, 
          child: Text(
            Places.places[8],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
  ),
      
      
      Container(
        color: Colors.grey[200],
        width: double.infinity,
        child: Image.asset(
          'lib/images/mete/SanGiovanni.jpg',
          height: 300, 
          fit: BoxFit.cover, 
        ),
      ),
      
    
      Expanded(
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          color: Colors.grey[300], 
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
          child: Text(
            Places.descriptions[8],
            style: TextStyle(fontSize: 16, height: 1.4),
            textAlign: TextAlign.justify,
          ),
          ),
        ),
      ),
    ],
  ),
),
Container(
    margin: EdgeInsets.all(20), 
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.grey[200], 
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3), 
          blurRadius: 25,
          spreadRadius: 5,
          offset: Offset(0, 0),
        ),
      ],
    ),
  
    clipBehavior: Clip.antiAlias, 
  
    child: Column(
      children: [
        
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          color: Colors.lightGreen, 
          child: Text(
            Places.places[9],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
  ),
      
      
      Container(
        color: Colors.grey[200],
        width: double.infinity,
        child: Image.asset(
          'lib/images/mete/Specola.jpg',
          height: 300, 
          fit: BoxFit.cover, 
        ),
      ),
      
    
      Expanded(
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          color: Colors.grey[300], 
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
          child: Text(
            Places.descriptions[9],
            style: TextStyle(fontSize: 16, height: 1.4),
            textAlign: TextAlign.justify,
          ),
          ),
        ),
      ),
    ],
  ),
),
    
  ];

  int get length => cards.length;

  Widget operator [](int? index) {
    return cards[index!];
  }

}

