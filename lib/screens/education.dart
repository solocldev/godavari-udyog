import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:maize_app/main.dart';
import 'package:maize_app/widgets/image_widget.dart';

class Education extends StatefulWidget {
  int month;
  Education({Key? key, required this.month}) : super(key: key);

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {
  var selected = false;
  var month;

  List<String> monthList = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  Widget monthScreen() {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Color.fromARGB(255, 255, 145, 0)])),
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                'Select Month',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 40,
                  margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Color(0xffEC9A2A)),
                    onPressed: () {
                      setState(() {
                        selected = true;
                        month = index + 1;
                      });
                    },
                    child: Text(
                      monthList[index],
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                );
              },
              itemCount: monthList.length,
            )
          ],
        )),
      ),
    );
  }

  Widget educationScreen(month) {
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
          child: SingleChildScrollView(
              child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('admins')
                .doc(MyApp.uid)
                .collection('posts')
                .where("month", isEqualTo: "${month}")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data!.docs.length == 0) {
                return const Center(
                  child: Text('No posts'),
                );
              }
              return Column(
                children: [
                  Text(
                    'Education',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${monthList[month - 1]}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ImageWidget(snapShot: snapshot.data!.docs[index]);
                    },
                  ),
                ],
              );
            },
          )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return selected ? educationScreen(month) : monthScreen();
  }
}
