import 'dart:io';
import 'package:flutter/material.dart';
import 'package:maize_app/main.dart';
import 'package:maize_app/screens/contactScreen.dart';
import 'package:maize_app/screens/home.dart';
import 'package:maize_app/screens/landing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Map<String, dynamic>> list = [
    {
      'icon': Icons.portrait,
      'title': 'My Account',
      'subtitle': 'Profile, Password, Notification',
    },
    {
      'icon': Icons.gps_fixed,
      'title': 'Address',
      'subtitle': 'Edit address,  Add address',
    },
    {
      'icon': Icons.settings,
      'title': 'Settings',
      'subtitle': 'Language, Region, Theme',
    },
    {
      'icon': Icons.help,
      'title': 'Help & Support',
      'subtitle': 'F.A.Q.s, Support, Links',
    },
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Icon(Icons.portrait),
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
                                  Text(MyApp.user['first_name']!,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    MyApp.user['number']!,
                                    style: TextStyle(color: Color(0xffEC9A2A)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                              child: const Text('Logout',
                                  style: TextStyle(color: Colors.blue)),
                              onTap: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                try {
                                  await prefs.remove('loggedIn');
                                  await prefs.remove('user');
                                  MyApp.loggedIn = false;
                                  print('done');
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LandingScreen()),
                                    (route) => false,
                                  );
                                } catch (e) {
                                  print(e);
                                }
                              },
                            )),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Divider(
                            thickness: 1,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Icon(list[index]['icon']),
                              ),
                              Expanded(
                                flex: 4,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          list[index]['title'],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          list[index]['subtitle'],
                                          style: TextStyle(
                                              color: Color(0xffEC9A2A)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  )
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
