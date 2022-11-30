import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maize_app/main.dart';
import 'package:maize_app/screens/createAccount.dart';
import 'package:maize_app/screens/home.dart';
import 'package:maize_app/utils/fuctions.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  final mobileNumber;
  static String? verificationCode;
  AuthScreen({Key? key, this.mobileNumber}) : super(key: key);
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 106, 106, 106)),
        borderRadius: BorderRadius.circular(50),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(50),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    var code = "";

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Color(0xffFFF6EA)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 8,
                24, MediaQuery.of(context).size.width / 8, 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Enter OTP code',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text(
                            'Enter the four digit OTP that sent to you via SMS.',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal)),
                        SizedBox(height: 20),
                        Pinput(
                          length: 6,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          submittedPinTheme: submittedPinTheme,
                          showCursor: true,
                          onChanged: (value) {
                            code = value;
                          },
                        ),
                      ]),
                  Container(
                    height: 40,
                    width: 120,
                    margin: EdgeInsets.symmetric(vertical: 100),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xffEC9A2A)),
                        onPressed: () async {
                          try {
                            PhoneAuthCredential credential =
                                PhoneAuthProvider.credential(
                                    verificationId:
                                        AuthScreen.verificationCode!,
                                    smsCode: code);

                            // await auth.signInWithCredential(credential);
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('loggedIn', true);

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => Home()),
                                (route) => false);
                          } catch (e) {
                            scaffoldMessage(context: context, message: '$e');
                            print(e);
                          }
                        },
                        child: Text('Continue')),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
