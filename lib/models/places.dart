

class Places{


  /*static const List<String> places = [
    "Cappella degli Scrovegni", 
    "Basilica di sant'Antonio", 
    "Prato della Valle", 
    "Palazzo della ragione", 
    "Orto Botanico", 
    "Palazzo del Bo", 
    "Piazza delle Erbe e della Frutta",
    "Caffè Pedrocchi",
    "Duomo e Battistero di San Giovanni",
    "La Specola"];

  static const List<String> descriptions = [
    "Questo gioiello dell'arte trecentesca custodisce il celebre ciclo di affreschi di Giotto, considerato una pietra miliare della pittura occidentale. Le pareti raccontano la storia di Maria e di Cristo, culminando nel maestoso Giudizio Universale. È un'esperienza immersiva unica, capace di lasciare ogni visitatore senza fiato per la vivacità dei colori e la modernità espressiva.",
    "Conosciuta dai padovani semplicemente come 'Il Santo', questa imponente basilica fonde stili romanico, gotico e bizantino in un'architettura armoniosa. Al suo interno sono custodite le reliquie del Santo e splendide opere d'arte di Donatello, tra cui l'altare maggiore. Le sue otto cupole e i campanili svettanti la rendono uno dei simboli più riconoscibili e visitati della città.",
    "Con i suoi quasi 90.000 metri quadrati, è una delle piazze più grandi d'Europa e un vero capolavoro urbanistico del XVIII secolo. Al centro si trova l'Isola Memmia, circondata da un canale ellittico ornato da 78 statue che ritraggono personaggi illustri legati alla città. È il cuore pulsante della vita cittadina, ideale per una passeggiata rilassante tra storia, mercati e architettura monumentale.",
    "Antica sede dei tribunali cittadini, questo palazzo medievale separa Piazza delle Erbe da Piazza della Frutta ed è famoso per il suo enorme salone pensile. Le pareti della sala superiore sono interamente decorate da un ciclo di affreschi a tema astrologico e religioso tra i più vasti al mondo. Al piano terra, sotto i voltoni, si trova ancora oggi lo storico mercato coperto, ricco di botteghe enogastronomiche tradizionali.",
    "Fondato nel 1545, è l'orto botanico universitario più antico del mondo ancora situato nella sua collocazione originaria e fa parte del Patrimonio UNESCO. Al suo interno si possono ammirare piante rare, esemplari storici come la 'Palma di Goethe' e il modernissimo Giardino della Biodiversità. È un luogo magico dove la ricerca scientifica secolare si sposa perfettamente con la bellezza e la varietà della natura.",
    "Sede storica dell'Università di Padova, una delle più antiche al mondo, ospita il celebre Teatro Anatomico stabile, il primo del suo genere. Camminare tra i suoi cortili significa ripercorrere i passi di giganti come Galileo Galilei e Copernico. La visita guidata permette di ammirare anche la cattedra di Galileo e la sala dedicata a Elena Lucrezia Cornaro Piscopia, la prima donna laureata al mondo.",
    "Queste due piazze gemelle, divise dal maestoso Palazzo della Ragione, rappresentano da secoli il cuore commerciale e sociale della città. Di giorno ospitano vivaci mercati all'aperto, mentre all'imbrunire si trasformano nel tempio del rito dell'aperitivo padovano. L'atmosfera che si respira tra i banchi di frutta e i tavolini dei bar è l'essenza più autentica e vibrante della vita cittadina.",
    "Conosciuto come il 'caffè senza porte' perché un tempo aperto giorno e notte, è uno dei caffè storici più famosi d'Italia e simbolo del Risorgimento. L'architettura eclettica unisce stili neoclassici e gotici, offrendo sale eleganti dove un tempo si riunivano intellettuali e studenti. È d'obbligo assaggiare il celebre 'Caffè Pedrocchi', servito in tazza grande con crema di menta e una spolverata di cacao, rigorosamente senza zucchero.",
    "Sebbene la Cattedrale sia imponente, il vero tesoro si trova nel Battistero adiacente, interamente decorato da un ciclo di affreschi trecenteschi di Giusto de' Menabuoi. Le scene bibliche coprono ogni centimetro delle pareti e della cupola, con un Paradiso circolare che lascia senza parole per precisione e colori. È considerato uno dei capolavori meglio conservati dell'arte pittorica medievale, spesso ingiustamente messo in ombra dalla Cappella degli Scrovegni.",
    "Situata in un'antica torre del castello dei Carraresi, questa struttura è stata trasformata nel XVIII secolo in un osservatorio astronomico all'avanguardia. Oggi ospita un affascinante museo dove è possibile ammirare strumenti astronomici antichi e godere di una vista mozzafiato sui canali della città. Il percorso museale racconta l'evoluzione della scienza celeste e il legame profondo tra Padova e lo studio dell'universo."
  ];*/

  static const List<String> cities = [
    "Padova",
    "Bologna",
    "Milano",
    "Roma",
    "Napoli",
    "Palermo",
  ];
  static const List<String> images = [
    "lib/images/scudetti/PadovaCalcio.png",


  ];

 static const List<int> _steps = [200, 3000, 1000, 2000, 5000, 2000, 1500, 300, 500, 1000];
  static const List<double> _hours = [0.25, 1.5, 1, 1, 3, 1, 0.5, 0.5, 1, 1.5];
  static const List<int> _crowded = [1, 3, 5, 4, 5, 3, 4, 6, 2, 1];
  static const List<bool> _opened = [false, false, true, false, true, false, true, false, false, false];

  // 2. Creiamo la lista batt calcolandola direttamente dai dati sopra
  static List<int> batt = List.generate(_steps.length, (i) {
    // Qui chiami la tua funzione pile() passando i dati i-esimi
    return pile(_steps[i], _hours[i], _crowded[i], _opened[i]);
  });


 static Map<String, List<dynamic>> mapDest = {"title": ["Cappella degli Scrovegni", 
    "Basilica di sant'Antonio", 
    "Prato della Valle", 
    "Palazzo della ragione", 
    "Orto Botanico", 
    "Palazzo del Bo", 
    "Piazza delle Erbe e della Frutta",
    "Caffè Pedrocchi",
    "Duomo e Battistero di San Giovanni",
    "La Specola"],
    "description": ["Questo gioiello dell'arte trecentesca custodisce il celebre ciclo di affreschi di Giotto, considerato una pietra miliare della pittura occidentale. Le pareti raccontano la storia di Maria e di Cristo, culminando nel maestoso Giudizio Universale. È un'esperienza immersiva unica, capace di lasciare ogni visitatore senza fiato per la vivacità dei colori e la modernità espressiva.",
    "Conosciuta dai padovani semplicemente come 'Il Santo', questa imponente basilica fonde stili romanico, gotico e bizantino in un'architettura armoniosa. Al suo interno sono custodite le reliquie del Santo e splendide opere d'arte di Donatello, tra cui l'altare maggiore. Le sue otto cupole e i campanili svettanti la rendono uno dei simboli più riconoscibili e visitati della città.",
    "Con i suoi quasi 90.000 metri quadrati, è una delle piazze più grandi d'Europa e un vero capolavoro urbanistico del XVIII secolo. Al centro si trova l'Isola Memmia, circondata da un canale ellittico ornato da 78 statue che ritraggono personaggi illustri legati alla città. È il cuore pulsante della vita cittadina, ideale per una passeggiata rilassante tra storia, mercati e architettura monumentale.",
    "Antica sede dei tribunali cittadini, questo palazzo medievale separa Piazza delle Erbe da Piazza della Frutta ed è famoso per il suo enorme salone pensile. Le pareti della sala superiore sono interamente decorate da un ciclo di affreschi a tema astrologico e religioso tra i più vasti al mondo. Al piano terra, sotto i voltoni, si trova ancora oggi lo storico mercato coperto, ricco di botteghe enogastronomiche tradizionali.",
    "Fondato nel 1545, è l'orto botanico universitario più antico del mondo ancora situato nella sua collocazione originaria e fa parte del Patrimonio UNESCO. Al suo interno si possono ammirare piante rare, esemplari storici come la 'Palma di Goethe' e il modernissimo Giardino della Biodiversità. È un luogo magico dove la ricerca scientifica secolare si sposa perfettamente con la bellezza e la varietà della natura.",
    "Sede storica dell'Università di Padova, una delle più antiche al mondo, ospita il celebre Teatro Anatomico stabile, il primo del suo genere. Camminare tra i suoi cortili significa ripercorrere i passi di giganti come Galileo Galilei e Copernico. La visita guidata permette di ammirare anche la cattedra di Galileo e la sala dedicata a Elena Lucrezia Cornaro Piscopia, la prima donna laureata al mondo.",
    "Queste due piazze gemelle, divise dal maestoso Palazzo della Ragione, rappresentano da secoli il cuore commerciale e sociale della città. Di giorno ospitano vivaci mercati all'aperto, mentre all'imbrunire si trasformano nel tempio del rito dell'aperitivo padovano. L'atmosfera che si respira tra i banchi di frutta e i tavolini dei bar è l'essenza più autentica e vibrante della vita cittadina.",
    "Conosciuto come il 'caffè senza porte' perché un tempo aperto giorno e notte, è uno dei caffè storici più famosi d'Italia e simbolo del Risorgimento. L'architettura eclettica unisce stili neoclassici e gotici, offrendo sale eleganti dove un tempo si riunivano intellettuali e studenti. È d'obbligo assaggiare il celebre 'Caffè Pedrocchi', servito in tazza grande con crema di menta e una spolverata di cacao, rigorosamente senza zucchero.",
    "Sebbene la Cattedrale sia imponente, il vero tesoro si trova nel Battistero adiacente, interamente decorato da un ciclo di affreschi trecenteschi di Giusto de' Menabuoi. Le scene bibliche coprono ogni centimetro delle pareti e della cupola, con un Paradiso circolare che lascia senza parole per precisione e colori. È considerato uno dei capolavori meglio conservati dell'arte pittorica medievale, spesso ingiustamente messo in ombra dalla Cappella degli Scrovegni.",
    "Situata in un'antica torre del castello dei Carraresi, questa struttura è stata trasformata nel XVIII secolo in un osservatorio astronomico all'avanguardia. Oggi ospita un affascinante museo dove è possibile ammirare strumenti astronomici antichi e godere di una vista mozzafiato sui canali della città. Il percorso museale racconta l'evoluzione della scienza celeste e il legame profondo tra Padova e lo studio dell'universo."
    ],
    "hours": _hours,
    "steps": _steps,
    "crowded": _crowded,
    "opened": _opened,
    "image": ["lib/images/mete/CappellaScrovegni.jpg",
      "lib/images/mete/BasilicaAntonio.jpg",
      "lib/images/mete/PratoValle.jpg",
      "lib/images/mete/PalazzoRagione.jpg",
      "lib/images/mete/OrtoBotanico.jpg",
      "lib/images/mete/PalazzoBo.jpg",
      "lib/images/mete/PiazzaFrutta.jpg",
      "lib/images/mete/CaffePedrocchi.jpg",
      "lib/images/mete/SanGiovanni.jpg",
      "lib/images/mete/Specola.jpg"],
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





static int pile(int steps, double hour, int crowded, bool opened){
  double points = 0;
  double intensity = steps / hour;

  if (intensity > 5000) {
    points += 7;
  } else if (intensity > 3000) {
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
  }

  if (points >= 8){
    return 3;}
  else if (points >= 5){
    return 2;}
  else{
    return 1;}} 

/*static List<int> getAllPiles() {
    List<int> results = [];
    int count = (mapDest["title"] as List).length;

    for (int i = 0; i < count; i++) {
      results.add(pile(
        mapDest["steps"]![i],
        mapDest["hours"]![i],
        mapDest["crowded"]![i],
        mapDest["opened"]![i],
      ));
    }
    return results;
  }*/



}