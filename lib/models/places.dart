

class Places{

  static const List<String> cities = [
    "Padova",
    
  ];
  static const List<String> images = [
    "lib/images/simbolo_padova.png",
  ];

 static const List<int> _steps = [200, 200, 3000, 0, 1000, 2000, 5000, 2000, 1500, 0, 500, 2000, 0 ];
  static const List<double> _hours = [0.25, 1.0, 1.5, 0.5, 1, 1, 3, 1, 0.5, 0.5, 1, 1.5, 1.5];
  static const List<int> _crowded = [1, 2, 3, 2, 5, 4, 5, 3, 4, 6, 2, 1, 3];
  static const List<bool> _opened = [false, true, false, false,  true, false, true, false, true, false, false, false, false];
  static const List<bool> _charge = [false, true, false, true, false, false,false, false,false, true,false, false, true];

  // 2. Creiamo la lista batt calcolandola direttamente dai dati sopra
  static List<int> batt = List.generate(_steps.length, (i) {
    // Qui chiami la tua funzione pile() passando i dati i-esimi
    return pile(_steps[i], _hours[i], _crowded[i], _opened[i], _charge[i]);
  });


 static Map<String, List<dynamic>> mapDest = {"title": ["Cappella degli Scrovegni", 
    "Giardini dell'Arena",
    "Basilica di sant'Antonio", 
    "Pasticceria Breda",
    "Prato della Valle", 
    "Palazzo della ragione", 
    "Orto Botanico", 
    "Palazzo del Bo", 
    "Piazza delle Erbe e della Frutta",
    "Caffè Pedrocchi",
    "Duomo e Battistero di San Giovanni",
    "La Specola",
    "Osteria Nane della Giulia"
  ],
    "description": ["This jewel of 14th-century art houses the famous cycle of frescoes by Giotto, considered a milestone of Western painting. The walls tell the story of Mary and Christ, culminating in the majestic Last Judgment. It is a unique immersive experience, capable of leaving every visitor breathless due to the vibrancy of the colors and the expressive modernity.",
    "The Arena Gardens of Padua blend a rich historical past, enclosed within the remains of the Roman amphitheater, the historic 14th-century walls, and Giotto's famous Scrovegni Chapel. Furthermore, it offers the possibility of a pleasant stop with an aperitif or a coffee in one of the park's kiosks.",
    "Known by locals simply as 'Il Santo', this imposing basilica blends Romanesque, Gothic, and Byzantine styles into a harmonious architecture. Inside, the relics of the Saint and splendid works of art by Donatello, including the high altar, are preserved. Its eight domes and soaring bell towers make it one of the city's most recognizable and visited symbols.",
    "Historic pastry shop in Padua, founded in 1967. Famous for its traditional desserts, including the Torta Pazientina. The ideal place for a quick and pleasant stop, not far from the city center, perfect for recharging your energy after a day of sightseeing.",
    "With its nearly 90,000 square meters, it is one of the largest squares in Europe and a true masterpiece of 18th-century urban planning. At the center is Isola Memmia, surrounded by an elliptical canal adorned with 78 statues depicting illustrious figures linked to the city. It is the beating heart of city life, ideal for a relaxing stroll amid history, markets, and monumental architecture.",
    "Ancient seat of the city courts, this medieval palace separates Piazza delle Erbe from Piazza della Frutta and is famous for its enormous suspended hall. The walls of the upper room are entirely decorated with a cycle of frescoes on astrological and religious themes among the most extensive in the world. On the ground floor, beneath the large vaults, the historic covered market is still located today, filled with traditional food and wine shops.",
    "Founded in 1545, it is the oldest university botanical garden in the world still located in its original setting and is a UNESCO World Heritage site. Inside, you can admire rare plants, historic specimens like 'Goethe's Palm', and the ultra-modern Biodiversity Garden. It is a magical place where centuries-old scientific research blends perfectly with the beauty and variety of nature.",
    "Historic seat of the University of Padua, one of the oldest in the world, it houses the famous permanent Anatomical Theatre, the first of its kind. Walking through its courtyards means retracing the steps of giants like Galileo Galilei and Copernicus. The guided tour also allows you to admire Galileo's chair and the room dedicated to Elena Lucrezia Cornaro Piscopia, the first woman to graduate in the world.",
    "These two twin squares, divided by the majestic Palazzo della Ragione, have represented the commercial and social heart of the city for centuries. By day they host lively open-air markets, while at dusk they transform into the temple of the Paduan aperitif ritual. The atmosphere felt among the fruit stalls and bar tables is the most authentic and vibrant essence of city life.",
    "Known as the 'café without doors' because it was once open day and night, it is one of the most famous historic cafés in Italy and a symbol of the Risorgimento. The eclectic architecture combines neoclassical and Gothic styles, offering elegant rooms where intellectuals and students once gathered. It is a must to taste the famous 'Caffè Pedrocchi', served in a large cup with mint cream and a dusting of cocoa, strictly without sugar.",
    "Although the Cathedral is imposing, the true treasure is found in the adjacent Baptistery, entirely decorated by a cycle of 14th-century frescoes by Giusto de' Menabuoi. The biblical scenes cover every inch of the walls and dome, with a circular Paradise that leaves you speechless due to its precision and colors. It is considered one of the best-preserved masterpieces of medieval painting, often unfairly overshadowed by the Scrovegni Chapel.",
    "Situated in an ancient tower of the Carraresi castle, this structure was transformed in the 18th century into a cutting-edge astronomical observatory. Today it houses a fascinating museum where it is possible to admire ancient astronomical instruments and enjoy a breathtaking view of the city's canals. The museum route tells the evolution of celestial science and the deep bond between Padua and the study of the universe.",
    "The oldest trattoria in Padua. A welcoming and familiar atmosphere that recreates the original 19th-century vibe. Genuine flavors of the Venetian tradition, tied to the seasons and with always fresh 0-km products. Located in a quiet area, far from the most beaten tourist tracks."
    ],
    "hours": _hours,
    "steps": _steps,
    "crowded": _crowded,
    "opened": _opened,
    "image": ["lib/images/mete/CappellaScrovegni.jpg",
      "lib/images/mete/GiardiniArena.jpg",
      "lib/images/mete/BasilicaAntonio.jpg",
      "lib/images/mete/Pazientina.jpg",
      "lib/images/mete/PratoValle.jpg",
      "lib/images/mete/PalazzoRagione.jpg",
      "lib/images/mete/OrtoBotanico.jpg",
      "lib/images/mete/PalazzoBo.jpg",
      "lib/images/mete/PiazzaFrutta.jpg",
      "lib/images/mete/CaffePedrocchi.jpg",
      "lib/images/mete/SanGiovanni.jpg",
      "lib/images/mete/Specola.jpg",
      "lib/images/mete/trattoria.jpg",
      ],
    "pile": batt

};


double calcoloDelta(int steps, double hour, int crowded, bool opened) {
  if (hour <= 0) return 0; // Evita divisione per zero

  int cp = 25; // Soglia Critica (%HRR)
  double durationMinutes = hour * 60;
  double stepsPerMin = steps / durationMinutes;
  
  double regrHRR = (0.4 * stepsPerMin) + 10;  // regressione lineare "forzata"
  double adjHRR = regrHRR + (crowded * 0.5) + (opened ? 5 : 0);  // aggiusto con coefficineti per affollamento e apertura

  double percHRR = adjHRR.round().toDouble(); // Arrotonda al numero intero più vicino

  double delta = 0; // inizializzo delta a 0
  
  if (percHRR > cp) { 
    // sfozo sopra-soglia ---> affaticamento
    delta = (percHRR - cp) * durationMinutes; 
  } 
  else if (percHRR > 20) {  
    // Zona Neutra 
    delta = 0; 
  } 
  else {
    // sforzo sotto-soglia --> recupero
    delta = 2.4 * (percHRR - cp) * durationMinutes;
  }
  
  return delta;
}





static int pile(int steps, double hour, int crowded, bool opened, bool charge) {
  double points = 0;
  double intensity = steps / hour;

  if (charge == true) {
    points = -1;
  }
  else { if (intensity > 1500) {
    points += 7;
  } else if (intensity > 900) {
    points += 4;
  } else {
    points += 2;
  }

  if (crowded > 7) {
    points += 4;
  } else if (crowded > 4) {
    points += 2;
  } else {
    points += 1;
  }

  if (opened == false) {
    points += 1;
  }}

  if (points == -1) {
    return -1;
  }
  else if (points >= 8){
    return 3;}
  else if (points >= 5){
    return 2;}
  
  else{
    return 1;}} 



}