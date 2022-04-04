import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weight_manager/constant.dart';
import 'package:weight_manager/screens/home.dart';
import 'package:weight_manager/services/database.dart';
import 'package:weight_manager/services/firebase_auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  DatabaseMethods databaseMethods = DatabaseMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Sign in anonymous",
          style: style,
        ),
      ),
      body: Center(
        child: SizedBox(
          width: getDeviceWidth(context) * 0.5,
          child: OutlinedButton(
            onPressed: () async {
              showProgressDialog(context);
              dynamic result = await _auth.signInAnonymous();
              if (result == null) {
                log("error signing in");
                return;
              } else {
                log("result : $result");
                UserCredential ab = result;
                Map<String, dynamic> userDataMap = {
                  "userId": ab.user!.uid,
                  "isAnonymous": ab.user!.isAnonymous,
                };
                databaseMethods.addUser(userDataMap);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                    (Route<dynamic> route) => false);
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.blue,
              ),
            ),
            child: Text(
              "Sign In",
              style: style.copyWith(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
