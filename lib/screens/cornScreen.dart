import 'dart:io';
import 'package:flutter/material.dart';
import 'package:maize_app/main.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class CornScreen extends StatefulWidget {
  const CornScreen({Key? key}) : super(key: key);

  @override
  State<CornScreen> createState() => _CornScreenState();
}

class _CornScreenState extends State<CornScreen> {
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
                  Text(
                    'Corn Quality',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Search for videos, shops and more',
                    ),
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                      child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Icon(Icons.portrait),
                            ),
                            Expanded(
                              flex: 6,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Godawari Udyog ',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(flex: 1, child: Icon(Icons.more_vert)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text('Corn Quality- Visual Indicator',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('Kernel Size',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text('Details about the Makka utpadan')
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 7),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('Minimum Yeild',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text('Details about the Makka utpadan')
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Image.asset('assets/images/corn.png'),
                        SizedBox(height: 30),
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
                        SizedBox(height: 30),
                        Divider(
                          thickness: 1,
                        ),
                        InkWell(
                          onTap: () {
                            launchUrl(Uri.parse("tel: 98998877665"));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Enquire with Godawari Udyog',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(Icons.phone)
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
                ],
              ),
            ),
          )),
    );
  }
}
