import 'dart:io';
import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
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
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(24),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search for videos, shops and more',
                  ),
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
                  Icon(Icons.phone, size: 50),
                  SizedBox(
                    height: 50,
                  ),
                  Text('98998877665',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                    onPressed: () {},
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
      ),
    );
  }
}
