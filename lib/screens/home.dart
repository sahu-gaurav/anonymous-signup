import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weight_manager/constant.dart';
import 'package:weight_manager/screens/add_user_weights.dart';
import 'package:weight_manager/screens/authenticate.dart';
import 'package:weight_manager/screens/update.dart';
import 'package:weight_manager/services/database.dart';
import 'package:weight_manager/services/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService get _auth => AuthService();
  DatabaseMethods databaseMethods = DatabaseMethods();

  deleteEntry({docId, userId}) {
    databaseMethods
        .deleteUserWeight(
          docId: docId,
          userId: userId,
        )
        .then((value) => refresh());
  }

  refresh() {
    // feedsList.clear();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Home",
          style: style,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await _auth.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const Authenticate(),
                  ),
                  (Route<dynamic> route) => false);
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UserWeight(),
            ),
          ).then((value) => refresh());
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('anonymousUsers')
            .doc(firebaseUserId)
            .collection('userWeights')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          log("snapshot : ${snapshot.data!.docs}");
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No Data.\nPress '+' to add data",
                style: style,
              ),
            );
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index];
                log("$data");
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                  child: SizedBox(
                    height: getDeviceHeight(context) * 0.125,
                    width: getDeviceWidth(context),
                    child: Card(
                      child: Wrap(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              left: 25,
                            ),
                            width: getDeviceWidth(context) * 0.8,
                            child: Text(
                              "Name: " + data['userName'],
                              style: style.copyWith(fontSize: 20),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 25,
                            ),
                            width: getDeviceWidth(context) * 0.8,
                            child: Text(
                              "Weight: " + data['userWeight'] + " kg",
                              style: style.copyWith(fontSize: 20),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateInfo(
                                        name: data['userName'],
                                        weight: data['userWeight'],
                                        docId: data.id,
                                      ),
                                    ),
                                  ).then((value) => refresh());
                                },
                                icon: const Icon(
                                  Icons.edit,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  deleteEntry(
                                      docId: data.id, userId: firebaseUserId);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
