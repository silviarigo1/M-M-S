//This is the main file of the app, where the app is initialized and the first screen is called. 
//It also contains the main widget of the app, which is a MaterialApp with a MultiProvider as home. 
//The MultiProvider allows to use multiple providers in the app, in this case we have a ResultSwipe provider and 
//a DataProvider provider. 

// Bibliography:

// - Quer G, Gouda P, Galarnyk M, Topol EJ, Steinhubl SR (2020) Inter- and intraindividual variability in daily resting heart rate and its
// associations with age, sex, sleep, BMI, and time of year: Retrospective, longitudinal cohort study of 92,457 adults. 
// PLoS ONE 15(2): e0227709. https://doi.org/10.1371/journal.pone.0227709

// - Ohayon, M., Wickwire, E. M., Hirshkowitz, M., Albert, S. M., Avidan, A., Daly, F. J., Dauvilliers, Y., Ferri, R., Fung, C., Gozal, D., Hazen, 
// N., Krystal, A., Lichstein, K., Mallampalli, M., Plazzi, G., Rawding, R., Scheer, F. A., Somers, V., & Vitiello, M. V. (2017). 
// National Sleep Foundation's sleep quality recommendations: first report. Sleep Health, 3, 6-19. 
// https://doi.org/10.1016/j.sleh.2016.11.006


import 'package:flutter/material.dart';
import 'package:mms_app/models/swipe.dart';
import 'package:mms_app/providers/data_provider.dart';
import 'package:mms_app/screens/splash.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider( //vedi esempio prof lezione 15 maggio
      providers: [
        ChangeNotifierProvider(create: (context) => ResultSwipe(), ),
        ChangeNotifierProvider(create: (context) => DataProvider()), 
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
          debugShowCheckedModeBanner: false,
          title: 'Login Page',
          home:  Splash(),
          )
    );
  }
  }



