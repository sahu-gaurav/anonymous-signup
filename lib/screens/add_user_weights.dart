import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weight_manager/constant.dart';
import 'package:weight_manager/services/database.dart';

class UserWeight extends StatefulWidget {
  const UserWeight({Key? key}) : super(key: key);

  @override
  State<UserWeight> createState() => _UserWeightState();
}

class _UserWeightState extends State<UserWeight> {
  TextEditingController weightController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  DatabaseMethods databaseMethods = DatabaseMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add weight",
          style: style,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
            child: TextFormField(
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
            child: TextFormField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your Weight (Kg)',
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (nameController.text.isEmpty ||
                    weightController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Add Value"),
                  ));
                  return;
                }
                DateTime now = DateTime.now();
                String formattedDate =
                    DateFormat('yyyy-MM-dd // kk:mm').format(now);
                log("date time : $formattedDate");
                Map<String, dynamic> userWeightDetails = {
                  "userName": nameController.text,
                  "userWeight": weightController.text,
                  'time': formattedDate,
                };
                databaseMethods
                    .addUserWeight(
                      userId: firebaseUserId,
                      userWeightDetails: userWeightDetails,
                    )
                    .then((value) => Navigator.pop(context));
              },
              child: Text(
                "Submit",
                style: style,
              ))
        ],
      ),
    );
  }
}
