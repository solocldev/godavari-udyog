import 'dart:io';
import 'package:flutter/material.dart';
import 'package:maize_app/main.dart';
import 'package:maize_app/screens/education.dart';
import 'package:maize_app/screens/navigation.dart';
import 'package:maize_app/screens/profileScreen.dart';
import 'package:maize_app/screens/upload.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, dynamic>> navigationList = [
    {
      "title": "Education",
      "icon": Icons.school,
      "navigate": 0,
    },
    {
      "title": "Market Rates",
      "icon": Icons.attach_money,
      'navigate': 1,
    },
    {
      "title": "Weather",
      "icon": Icons.cloud,
      'navigate': 2,
    },
    {
      "title": "Services",
      "icon": Icons.miscellaneous_services,
      'navigate': 3,
    },
    {
      "title": "Corn Quality",
      "icon": Icons.high_quality,
      'navigate': 4,
    },
    {
      "title": "Helpdesk",
      "icon": Icons.help,
      'navigate': 5,
    }
  ];

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
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Icon(Icons.notifications),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UploadImageScreen(),
                                ));
                          },
                        ),
                        SizedBox(width: 5),
                        InkWell(
                          child: Icon(Icons.portrait),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Profile(),
                                ));
                          },
                        ),
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
                            InkWell(
                              child: Container(
                                height: MediaQuery.of(context).size.width / 4,
                                width: MediaQuery.of(context).size.width / 4,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Icon(
                                  navigationList[index]['icon'],
                                  size: 90,
                                ),
                              ),
                              onTap: () {
                                NavitionScreen.selectedIndex =
                                    navigationList[index]['navigate'];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NavitionScreen(),
                                    ));
                              },
                            ),
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
      ),
    );
  }
}
