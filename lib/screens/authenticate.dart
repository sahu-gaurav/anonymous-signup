import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weight_manager/constant.dart';
import 'package:weight_manager/screens/home.dart';
import 'package:weight_manager/screens/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  late FirebaseAuth _auth;
  User? _user;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    if (_user != null) firebaseUserId = _user!.uid;
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : _user == null
            ? const SignIn()
            : const Home();
  }
}
