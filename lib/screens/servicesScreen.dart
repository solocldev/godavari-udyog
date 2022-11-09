import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maize_app/main.dart';
import 'package:url_launcher/url_launcher.dart';

class Services extends StatelessWidget {
  const Services({Key? key}) : super(key: key);

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
                  'Weather',
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
                    child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('services')
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
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 5),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xffEC9A2A)),
                                onPressed: () {
                                  launchUrl(Uri.parse(
                                      "tel: ${snapshot.data!.docs[index]['contact']}"));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                  '${snapshot.data!.docs[index]['name']}, ${snapshot.data!.docs[index]['location']}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Text(
                                                  '${snapshot.data!.docs[index]['service']}',
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      ),
                                      InkWell(
                                        child: Icon(Icons.phone),
                                        onTap: () => launchUrl(Uri.parse(
                                            "tel: ${snapshot.data!.docs[index]['contact']}")),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
      ),
    );
  }
}
