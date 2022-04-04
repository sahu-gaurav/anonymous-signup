import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<void> addUser(userData) async {
    FirebaseFirestore.instance
        .collection("anonymousUsers")
        .add(userData)
        .catchError((e) {
      log(e.toString());
    });
  }

  Future<void> addUserWeight({userId, userWeightDetails}) async {
    FirebaseFirestore.instance
        .collection("anonymousUsers")
        .doc(userId)
        .collection("userWeights")
        .add(userWeightDetails)
        .catchError((e) {
      log(e);
    });
  }

  Future<void> updateUserWeight({userId, userWeightDetails, docId}) async {
    FirebaseFirestore.instance
        .collection("anonymousUsers")
        .doc(userId)
        .collection("userWeights")
        .doc(docId)
        .set(userWeightDetails)
        .catchError((e) {
      log(e);
    });
  }

  Future<void> deleteUserWeight({userId, docId}) async {
    FirebaseFirestore.instance
        .collection("anonymousUsers")
        .doc(userId)
        .collection("userWeights")
        .doc(docId)
        .delete()
        .catchError((e) {
      log(e);
    });
  }
}
