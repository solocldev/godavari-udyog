import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:maize_app/screens/home.dart';
import 'package:maize_app/screens/landing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(
      prefs: prefs,
    ),
  ));
}

class MyApp extends StatefulWidget {
  static Map<String, String> user = {
    'id': '',
    'first_name': 'Sarthak',
    'last_name': 'Pawar',
    'taluka_name': 'Palus',
    'village_name': 'Dhule',
    'district_name': 'Sangli',
    'number': '98998877665'
  };
  static bool loggedIn = false;
  static String uid = 'r4JUENKSmnOeUXVJ8UOt';
  final prefs;
  static int mainIndex = 0;
  static int prevIndex = -1;
  MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? mobileNumber = '';

  Widget navigate() {
    MyApp.loggedIn = widget.prefs.getBool('loggedIn') == null ? false : true;
    if (widget.prefs.getBool('loggedIn') != null &&
        widget.prefs.getString('user') != null) {
      final user = jsonDecode(widget.prefs.getString('user'));
      final Map<String, String> json = {
        'id': user['id'],
        'first_name': user['first_name'],
        'last_name': user['last_name'],
        'taluka_name': user['taluka_name'],
        'village_name': user['village_name'],
        'district_name': user['district_name'],
        'number': user['number'],
      };
      MyApp.user = json;
    }
    return MyApp.loggedIn ? Home() : LandingScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigate(),
      // body: WeatherScreen(),
    );
  }
}
