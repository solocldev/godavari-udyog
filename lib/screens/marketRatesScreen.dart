import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maize_app/main.dart';
import 'package:share/share.dart';

class MarketRates extends StatefulWidget {
  const MarketRates({Key? key}) : super(key: key);

  @override
  State<MarketRates> createState() => _MarketRatesState();
}

class _MarketRatesState extends State<MarketRates> {
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
        body: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                'Market Rates',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Search for videos, shops and more',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                  child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('admins')
                    .doc(MyApp.uid)
                    .collection('rates')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return Container(
                                child: Column(
                              children: [
                                Row(children: [
                                  Text(
                                      '${snapshot.data!.docs[index]['day']} , ${snapshot.data!.docs[index]['date']}',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic)),
                                ]),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  'Rs. ${snapshot.data!.docs[index]['price']} \n per kilo',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 30,
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
                                    label: Text('share')),
                              ],
                            ));
                          }
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                          '${snapshot.data!.docs[index]['day']}',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          '${snapshot.data!.docs[index]['date']}',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                              Text(
                                'Rs. ${snapshot.data!.docs[index]['price']} per kilo',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
