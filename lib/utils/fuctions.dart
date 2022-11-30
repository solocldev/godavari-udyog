import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maize_app/main.dart';
import 'package:maize_app/screens/authentication.dart';
import 'package:maize_app/screens/createAccount.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future authentication(
    {BuildContext? context, String? mobileNumber, find}) async {
  if (find.docs.toList().isEmpty) {
    Navigator.push(
      context!,
      MaterialPageRoute(
          builder: (context) =>
              CreateAccountScreen(mobileNumber: mobileNumber)),
    );
    return;
  }
  try {
    FirebaseAuth auth = FirebaseAuth.instance;
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91 $mobileNumber',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Error ${e}");
      },
      codeSent: (String verificationId, int? resendToken) {
        print(verificationId);
        AuthScreen.verificationCode = verificationId;
        scaffoldMessage(context: context, message: 'Otp incoming!!');
        Navigator.push(
          context!,
          MaterialPageRoute(
              builder: (context) => AuthScreen(
                    mobileNumber: verificationId,
                  )),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    final user = find.docs.toList()[0];
    final Map<String, String> json = {
      'id': user['id'],
      'first_name': user['first_name'],
      'last_name': user['last_name'],
      'taluka_name': user['taluka_name'],
      'village_name': user['village_name'],
      'district_name': user['district_name'],
      'number': user['number'],
    };
    MyApp.user = json;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(json));
  } catch (e) {}
}

scaffoldMessage({BuildContext? context, String? message}) {
  ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
      content: Text(message!), duration: Duration(milliseconds: 3000)));
}
