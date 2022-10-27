import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:maize_app/screens/authentication.dart';
import 'package:maize_app/screens/contactScreen.dart';
import 'package:maize_app/screens/cornScreen.dart';
import 'package:maize_app/screens/createAccount.dart';
import 'package:maize_app/screens/education.dart';
import 'package:maize_app/screens/home.dart';
import 'package:maize_app/screens/landing.dart';
import 'package:maize_app/screens/marketRatesScreen.dart';
import 'package:maize_app/screens/monthScreen.dart';
import 'package:maize_app/screens/numberScreen.dart';
import 'package:maize_app/screens/profileScreen.dart';
import 'package:maize_app/screens/servicesScreen.dart';
import 'package:maize_app/screens/upload.dart';
import 'package:maize_app/screens/weather.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  static Map<String, String> user = {
    'id': '',
    'first_name': 'Sarthak',
    'last_name': 'Pawar',
    'taluka_name': 'Dhule',
    'village_name': 'Dhule',
    'district_name': 'Dhule',
    'number': '9284201590'
  };
  static bool loggedIn = true;
  static String uid = 'r4JUENKSmnOeUXVJ8UOt';
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? mobileNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyApp.loggedIn == false ? const LandingScreen() : Home(),
    );
  }
}
