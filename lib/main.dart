import 'package:cash_splitter/screens/bill_screen.dart';
import 'package:cash_splitter/screens/final_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import './screens/overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'cash splitter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/images/app-icon.png'),
        nextScreen: OverviewScreen(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.redAccent,
        duration: 800,
      ),
      routes: {
        OverviewScreen.routeName: (ctx) => OverviewScreen(),
        BillScreen.routeName: (ctx) => BillScreen(),
        FinalScreen.routeName: (ctx) => FinalScreen()
      },
    );
  }
}
