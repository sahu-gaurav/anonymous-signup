import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:weight_manager/constant.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInAnonymous() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      firebaseUserId = userCredential.user!.uid;
      return userCredential;
    } catch (e) {
      log("$e");
      return null;
    }
  }

  Future signOut() async {
    await _auth.signOut();
  }
}
