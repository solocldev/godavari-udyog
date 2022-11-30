import 'dart:io';
import 'package:flutter/material.dart';
import 'package:maize_app/main.dart';
import 'package:maize_app/screens/contactScreen.dart';
import 'package:maize_app/screens/cornScreen.dart';
import 'package:maize_app/screens/education.dart';
import 'package:maize_app/screens/home.dart';
import 'package:maize_app/screens/marketRatesScreen.dart';
import 'package:maize_app/screens/profileScreen.dart';
import 'package:maize_app/screens/servicesScreen.dart';
import 'package:maize_app/screens/weather.dart';

class NavitionScreen extends StatefulWidget {
  static int selectedIndex = 0;
  NavitionScreen({Key? key}) : super(key: key);
  @override
  State<NavitionScreen> createState() => _NavitionScreenState();
}

class _NavitionScreenState extends State<NavitionScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Education(
      month: 1,
    ),
    MarketRates(),
    WeatherScreen(),
    Services(),
    CornScreen(),
    ContactScreen()
  ];
  void _onItemTapped(int index) {
    if (index == 0 && MyApp.prevIndex != 0) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
        (route) => false,
      );
    } else if (index == 1 && MyApp.prevIndex != 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Profile(),
        ),
      );
    } else if (index == 2 && MyApp.prevIndex != 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ContactScreen(
            homeCall: true,
          ),
        ),
      );
    }
    if (MyApp.prevIndex == -1) {
      MyApp.prevIndex = index;
    }
    if (MyApp.prevIndex != index) {
      MyApp.prevIndex = index;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Color(0xffFFF6EA)])),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset('assets/images/company_logo.png'),
                    ),
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(MyApp.user['taluka_name']!,
                                  style: TextStyle(fontSize: 20)),
                              Text(
                                MyApp.user['district_name']!,
                                style: TextStyle(color: Color(0xffEC9A2A)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.notifications),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        body: _widgetOptions.elementAt(NavitionScreen.selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.portrait_rounded),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.phone),
              label: 'Help Desk',
            ),
          ],
          currentIndex: MyApp.mainIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
