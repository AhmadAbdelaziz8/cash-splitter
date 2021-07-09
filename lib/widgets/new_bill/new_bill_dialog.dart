import 'dart:ui';
import 'package:flutter/material.dart';

import '../new_bill/dialog_form.dart';
import 'package:cash_splitter/providers/models.dart';

int peopleNo = 0;
String billTitle;
Bill bill = Bill();

openBillDialog(BuildContext context) {
  final screenSize = MediaQuery.of(context).size;

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return 
      AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        contentPadding: EdgeInsets.all(16.0),
        content: DialogForm(),
      );
      // AlertDialog(
      //   shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(32.0))),
      //   contentPadding: EdgeInsets.only(top: 10.0),
      //   content: Container(
      //     // padding: EdgeInsets.only(bottom: 15),
      //     height: screenSize.height * 0.42,
      //     // child: SingleChildScrollView(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       // crossAxisAlignment: CrossAxisAlignment.center,
      //       // mainAxisSize: MainAxisSize.min,
      //       children: <Widget>[
      //         // Flexible(
      //         // child:
      //         Flexible(
      //           child: Container(
      //             margin: const EdgeInsets.only(top: 20, bottom: 20),
      //             child: Text(
      //               "New Bill",
      //               style:
      //                   TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      //             ),
      //           ),
      //         ),
      //         DialogForm(),
      //       ],
      //     ),
      //   ),
      //   // ),
      // );
    },
  );
}
