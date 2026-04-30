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
          child: Row( 
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ 
            Text( Places.mapDest["title"]![0],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
           Text(emoji(Places.mapDest["pile"]![0]),
            ),
          ],),
        ),
      
        Container(
        color: Colors.grey[200],
        width: double.infinity,
        child: Image.asset(
          Places.mapDest["image"]![0],
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
            Places.mapDest["description"]![0],
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
          child: Row( 
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ 
            Text( Places.mapDest["title"]![1],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
           Text(emoji(Places.mapDest["pile"]![1]),
            ),
          ],),
  ),
      
      
      Container(
        color: Colors.grey[200],
        width: double.infinity,
        child: Image.asset(
          Places.mapDest["image"]![1],
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
            Places.mapDest["description"]![1],
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
          child: Row( 
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ 
            Text( Places.mapDest["title"]![2],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
           Text(emoji(Places.mapDest["pile"]![2]),
            ),
          ],),
  ),
      
      
      Container(
        color: Colors.grey[200],
        width: double.infinity,
        child: Image.asset(
          Places.mapDest["image"]![2],
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
            Places.mapDest["description"]![2],
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
          child: Row( 
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ 
            Text( Places.mapDest["title"]![3],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
           Text(emoji(Places.mapDest["pile"]![3]),
            ),
          ],),
  ),
      
      
      Container(
        color: Colors.grey[200],
        width: double.infinity,
        child: Image.asset(
          Places.mapDest["image"]![3],
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
            Places.mapDest["description"]![3],
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
          child: Row( 
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ 
            Text( Places.mapDest["title"]![4],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
           Text(emoji(Places.mapDest["pile"]![4]),
            ),
          ],),
  ),
      
      
      Container(
        color: Colors.grey[200],
        width: double.infinity,
        child: Image.asset(
          Places.mapDest["image"]![4],
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
            Places.mapDest["description"]![4],
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
          child: Row( 
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ 
            Text( Places.mapDest["title"]![5],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
           Text(emoji(Places.mapDest["pile"]![5]),
            ),
          ],),
  ),
      
      
      Container(
        color: Colors.grey[200],
        width: double.infinity,
        child: Image.asset(
          Places.mapDest["image"]![5],
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
            Places.mapDest["description"]![5],
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
          child: Row( 
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ 
            Text( Places.mapDest["title"]![6],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
           Text(emoji(Places.mapDest["pile"]![6]),
            ),
          ],),
  ),
      
      
      Container(
        color: Colors.grey[200],
        width: double.infinity,
        child: Image.asset(
          Places.mapDest["image"]![6],
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
            Places.mapDest["description"]![6],
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
          child: Row( 
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ 
            Text( Places.mapDest["title"]![7],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
           Text(emoji(Places.mapDest["pile"]![7]),
            ),
          ],),
  ),
      
      
      Container(
        color: Colors.grey[200],
        width: double.infinity,
        child: Image.asset(
          Places.mapDest["image"]![7],
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
            Places.mapDest["description"]![7],
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
          child: Row( 
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ 
            Text( Places.mapDest["title"]![8],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
           Text(emoji(Places.mapDest["pile"]![8]),
            ),
          ],),
  ),
      
      
      Container(
        color: Colors.grey[200],
        width: double.infinity,
        child: Image.asset(
          Places.mapDest["image"]![8],
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
            Places.mapDest["description"]![8],
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
          child: Row( 
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ 
            Text( Places.mapDest["title"]![9],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
           Text(emoji(Places.mapDest["pile"]![9]),
            ),
          ],),
  ),
      
      
      Container(
        color: Colors.grey[200],
        width: double.infinity,
        child: Image.asset(
          Places.mapDest["image"]![9],
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
            Places.mapDest["description"]![9],
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


String emoji(int numPile){
  if(numPile == 1) {return '🔋';}
  else if(numPile == 2) {return '🔋🔋';}
  return '🪫🪫🪫';
  
  
}