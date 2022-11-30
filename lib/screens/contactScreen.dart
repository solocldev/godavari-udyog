import 'dart:io';
import 'package:flutter/material.dart';
import 'package:maize_app/main.dart';
import 'package:maize_app/screens/home.dart';
import 'package:maize_app/screens/profileScreen.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  final bool? homeCall;
  const ContactScreen({Key? key, this.homeCall}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
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
            colors: [Colors.white, Color(0xffFFF6EA)]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: widget.homeCall != null
            ? AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.black,
              )
            : null,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  'Helpdesk',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Column(children: [
                  SizedBox(
                    height: 24,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text('Contact Us\nFor any help with the app',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))
                  ]),
                  SizedBox(
                    height: 100,
                  ),
                  InkWell(
                      onTap: () {
                        launchUrl(Uri.parse("tel: 98998877665"));
                      },
                      child: Icon(Icons.phone, size: 50)),
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      launchUrl(Uri.parse("tel: 98998877665"));
                    },
                    child: Text('98998877665',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                      onPrimary: Colors.black,
                    ),
                    onPressed: () {
                      Share.share('https://www.solocl.com',
                          subject: 'checkout solocl');
                    },
                    icon: Icon(
                      Icons.share,
                      size: 24.0,
                    ),
                    label: Text('Share'),
                  ),
                ]),
              ],
            ),
          ),
        ),
        bottomNavigationBar: widget.homeCall != null
            ? BottomNavigationBar(
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
              )
            : null,
      ),
    );
  }
}
