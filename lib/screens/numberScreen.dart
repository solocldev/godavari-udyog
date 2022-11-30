import 'dart:io';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maize_app/screens/authentication.dart';
import 'package:maize_app/screens/createAccount.dart';
import 'package:maize_app/utils/fuctions.dart';

class NumberScreen extends StatefulWidget {
  const NumberScreen({Key? key}) : super(key: key);
  @override
  State<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  final _numberController = TextEditingController();

  navigateScreen() async {
    try {
      final find = await FirebaseFirestore.instance
          .collection("users")
          .where("number", isEqualTo: '${_numberController.text}')
          .get();
      authentication(
          context: context, mobileNumber: _numberController.text, find: find);
    } catch (e) {
      print(e);
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
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Text('Enter your mobile number'),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: TextField(
                            controller: _numberController,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Mobile Number',
                            ),
                          ),
                        ),
                        Text(
                            'You will receive a SMS to verify your phone number that may apply message or data rates.')
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 120,
                    margin: EdgeInsets.symmetric(vertical: 100),
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xffEC9A2A)),
                      onPressed: () async {
                        if (_numberController.text != '' &&
                            _numberController.text.length == 10) {
                          navigateScreen();
                        }
                      },
                      child: Text('Get OTP', style: TextStyle(fontSize: 18)),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
