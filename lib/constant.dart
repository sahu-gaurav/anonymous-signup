import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextStyle style = const TextStyle(fontSize: 16);
late String firebaseUserId;

getDeviceHeight(context) {
  var deviceHeight = MediaQuery.of(context).size.height;
  return deviceHeight;
}

getDeviceWidth(context) {
  var deviceWidth = MediaQuery.of(context).size.width;
  return deviceWidth;
}

showProgressDialog(BuildContext context) {
  // set up the button

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white,
    // title: Text("FreeCanSee", style: ktextStyle),
    content: Container(
      height: 100,
      child: Center(
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          const CircularProgressIndicator(),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Please Wait",
            style: style.copyWith(
              fontSize: 18,
            ),
          ),
        ]),
      ),
    ),
    // actions: [],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
