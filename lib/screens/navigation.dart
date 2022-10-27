import 'dart:io';
import 'package:flutter/material.dart';
import 'package:maize_app/main.dart';
import 'package:maize_app/screens/contactScreen.dart';
import 'package:maize_app/screens/cornScreen.dart';
import 'package:maize_app/screens/education.dart';
import 'package:maize_app/screens/home.dart';
import 'package:maize_app/screens/marketRatesScreen.dart';
import 'package:maize_app/screens/servicesScreen.dart';

class NavitionScreen extends StatefulWidget {
  static int selectedIndex = 0;
  NavitionScreen({Key? key}) : super(key: key);
  @override
  State<NavitionScreen> createState() => _NavitionScreenState();
}

class _NavitionScreenState extends State<NavitionScreen> {
  static List<Widget> _widgetOptions = <Widget>[
    Education(
      month: 1,
    ),
    MarketRates(),
    Text(
      'Index 3: Weather',
    ),
    Services(),
    CornScreen(),
    ContactScreen()
  ];
  void _onItemTapped(int index) {
    setState(() {
      NavitionScreen.selectedIndex = index;
    });
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
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                        child: Icon(Icons.home),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                  ),
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
                        Icon(
                          Icons.arrow_drop_down,
                          color: Color(0xffEC9A2A),
                          size: 30,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications),
                        SizedBox(width: 5),
                        Icon(Icons.portrait),
                      ],
                    ),
                  ),
                ],
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
              icon: Icon(Icons.school),
              label: 'Education',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: 'Market Rates',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud),
              label: 'Weather',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.miscellaneous_services),
              label: 'Services',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.high_quality),
              label: 'Corn Quality',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help),
              label: 'Helpdesk',
            ),
          ],
          currentIndex: NavitionScreen.selectedIndex,
          selectedItemColor: Color(0xffEC9A2A),
          unselectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
