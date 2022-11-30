import 'dart:io';
import 'package:flutter/material.dart';
import 'package:maize_app/main.dart';
import 'package:maize_app/screens/AdminNavigation.dart';
import 'package:maize_app/screens/contactScreen.dart';
import 'package:maize_app/screens/education.dart';
import 'package:maize_app/screens/landing.dart';
import 'package:maize_app/screens/navigation.dart';
import 'package:maize_app/screens/profileScreen.dart';
import 'package:maize_app/screens/upload.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> navigationList = [
    {
      "title": "Education",
      "icon": 'assets/icons/reading.png',
      "navigate": 0,
    },
    {
      "title": "Market Rates",
      "icon": 'assets/icons/rupee.png',
      'navigate': 1,
    },
    {
      "title": "Weather",
      "icon": 'assets/icons/cloudy.png',
      'navigate': 2,
    },
    {
      "title": "Services",
      "icon": 'assets/icons/tractor.png',
      'navigate': 3,
    },
    {
      "title": "Corn Quality",
      "icon": 'assets/icons/corn.png',
      'navigate': 4,
    },
    {
      "title": "Helpdesk",
      "icon": 'assets/icons/help.png',
      'navigate': 5,
    }
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
                            InkWell(
                                child: Icon(Icons.notifications), onTap: () {}),
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    'welcome to agro maize',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Search for videos, shops and more',
                    ),
                  ),
                  GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 30,
                      ),
                      itemCount: navigationList.length,
                      itemBuilder: (_, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              child: Image.asset(
                                navigationList[index]['icon'],
                                height: MediaQuery.of(context).size.width / 4,
                                width: MediaQuery.of(context).size.width / 4,
                              ),
                              onTap: () {
                                MyApp.prevIndex = -1;
                                NavitionScreen.selectedIndex =
                                    navigationList[index]['navigate'];
                                if (NavitionScreen.selectedIndex == 5) {
                                  MyApp.prevIndex = 2;
                                }
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NavitionScreen(),
                                    ));
                              },
                            ),
                            // InkWell(
                            //   child: Container(
                            //     height: MediaQuery.of(context).size.width / 4,
                            //     width: MediaQuery.of(context).size.width / 4,
                            //     decoration: const BoxDecoration(
                            //       shape: BoxShape.circle,
                            //       color: Colors.white,
                            //     ),
                            //   ),
                            //   onTap: () {
                            //     NavitionScreen.selectedIndex =
                            //         navigationList[index]['navigate'];
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //           builder: (context) => NavitionScreen(),
                            //         ));
                            //   },
                            // ),
                            SizedBox(height: 7),
                            Text(
                              navigationList[index]['title'],
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
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
