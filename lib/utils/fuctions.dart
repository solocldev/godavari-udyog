import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maize_app/screens/authentication.dart';
import 'package:maize_app/screens/createAccount.dart';

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
      phoneNumber: '+91 ${mobileNumber}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Error ${e}");
      },
      codeSent: (String verificationId, int? resendToken) {
        print(verificationId);
        CreateAccountScreen.verify = verificationId;
        scaffoldMessage(context: context, message: 'Otp incoming!!');
        Navigator.push(
          context!,
          MaterialPageRoute(
              builder: (context) => AuthScreen(
                    mobileNumber: mobileNumber,
                  )),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  } catch (e) {}
}

scaffoldMessage({BuildContext? context, String? message}) {
  ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
      content: Text(message!), duration: Duration(milliseconds: 3000)));
}
