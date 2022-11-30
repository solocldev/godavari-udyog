import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maize_app/main.dart';
import 'package:maize_app/utils/fuctions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateAccountScreen extends StatefulWidget {
  String? mobileNumber;

  static String? verify;
  CreateAccountScreen({Key? key, required this.mobileNumber}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _talukaNameController = TextEditingController();
  final _villageNameController = TextEditingController();
  final _districtNameController = TextEditingController();
  final _numberController = TextEditingController();

  final _options = [
    [
      'Shirala',
      'Walwa',
      'Palus',
      'Kadegaon',
      'Khanapur (Vita)',
      'Atpadi',
      'Tasgaon',
      'Miraj',
      'Kavathe Mahankal',
      'Jat, Sangli'
    ],
    [
      'Satara',
      'Karad',
      'Wai',
      'Koregaon',
      'Jaoli',
      'Mahabaleshwar',
      'Khandala',
      'Patan',
      'Phaltan',
      'Khatav',
      'Maan'
    ],
    [
      'Panhala',
      'Shahuwadi',
      'Ichalkaranji',
      'Shirol',
      'Hatkanangale',
      'Karveer',
      'Gaganbawada',
      'Radhanagari',
      'Kagal',
      'Bhudaragad',
      'Ajara',
      'Gadhinglaj',
      'Chandgad'
    ],
    [
      'North Solapur',
      'South Solapur',
      'Akkalkot',
      'Barshi',
      'Mangalwedha',
      'Pandharpur',
      'Sangola',
      'Malshiras',
      'Mohol',
      'Madha',
      'Karmala'
    ],
  ];

  final districts = ['Sangli', 'Satara', 'Kolhapur', 'Solapur'];

  var dropdownvalue;
  var dropdownvaluetaluka;
  var talukaList;
  var selected = false;

  List<String> returnTaluka(value) {
    List<String> talukaList = ['Shirala'];
    if (value == 'Sangli') {
      talukaList = _options[0];
    } else if (value == 'Satara') {
      talukaList = _options[1];
    } else if (value == 'Kolhapur') {
      talukaList = _options[2];
    } else if (value == 'Solapur') {
      talukaList = _options[3];
    }
    return talukaList;
  }

  Future createUser() async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    final json = {
      'id': docUser.id,
      'first_name': _firstNameController.text,
      'last_name': _lastNameController.text,
      'taluka_name': _talukaNameController.text,
      'village_name': _villageNameController.text,
      'district_name': _districtNameController.text,
      'number': _numberController.text
    };
    MyApp.user = json;
    try {
      await docUser.set(json);
      final find = await FirebaseFirestore.instance
          .collection("users")
          .where("number", isEqualTo: '${_numberController.text}')
          .get();
      authentication(
              context: context, mobileNumber: widget.mobileNumber, find: find)
          .whenComplete(() => scaffoldMessage(
              context: context, message: 'You are registered!!'));
      setState(() {
        widget.mobileNumber = _numberController.text;
      });
    } catch (e) {
      scaffoldMessage(context: context, message: 'An error occured!!');
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(json));
  }

  void initState() {
    _numberController.text = widget.mobileNumber!;
    talukaList = _options[0];
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
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          title: Text('Create an account'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: Text(
                  'Welcome to Agro Maize app',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                )),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Begin your learning here',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'First Name',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Last Name',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextField(
                    controller: _villageNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Village Name',
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                          color: Colors.grey,
                          style: BorderStyle.solid,
                          width: 1.2),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: true,
                        items: districts
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: dropdownvalue,
                        icon: Icon(Icons.keyboard_arrow_down),
                        onChanged: (Object? value) {
                          setState(() {
                            if (value == 'Sangli') {
                              talukaList = _options[0];
                            } else if (value == 'Satara') {
                              talukaList = _options[1];
                            } else if (value == 'Kolhapur') {
                              talukaList = _options[2];
                            } else if (value == 'Solapur') {
                              talukaList = _options[3];
                            }
                            dropdownvaluetaluka = null;
                            dropdownvalue = value!;
                            _districtNameController.text = dropdownvalue;
                          });
                        },
                        hint: Text('District Name'),
                      ),
                    )),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                          color: Colors.grey,
                          style: BorderStyle.solid,
                          width: 1.2),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: true,
                        items: talukaList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: dropdownvaluetaluka,
                        icon: Icon(Icons.keyboard_arrow_down),
                        onChanged: (Object? value) {
                          setState(() {
                            dropdownvaluetaluka = value!;
                            _talukaNameController.text = dropdownvaluetaluka;
                          });
                        },
                        hint: Text('Taluka Name'),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextField(
                    controller: _numberController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mobile Number',
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  margin: EdgeInsets.all(5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Color(0xffEC9A2A)),
                    child: Text('Create Account'),
                    onPressed: () {
                      if (_districtNameController.text != '' &&
                          _talukaNameController.text != '' &&
                          _villageNameController.text != '' &&
                          _firstNameController.text != '' &&
                          _lastNameController.text != '' &&
                          _numberController.text != '' &&
                          _numberController.text.length == 10) {
                        createUser();
                      } else {
                        scaffoldMessage(
                            context: context,
                            message: 'You need to fill all the fields!!');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
