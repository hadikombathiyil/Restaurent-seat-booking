import 'package:finalproject/firebase_options.dart';
import 'package:finalproject/view/screens/splashscreen/splashscreen.dart';
import 'package:finalproject/viewmodel/bottombar/bottombar.dart';
import 'package:finalproject/view/screens/bookingscreen/bookingscreen.dart';
import 'package:finalproject/view/screens/confirmedscreen/confirmedscreen.dart';
import 'package:finalproject/view/screens/historyscreen/historyscreen.dart';
import 'package:finalproject/view/screens/homescreen/confirmscreen.dart/homescreen/homescreen.dart';
import 'package:finalproject/view/screens/profilescreen/profilescreen.dart';
import 'package:finalproject/view/screens/restuarentscreen/restuarentscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: SplashScreen(),
    );
  }
}
