import 'package:cash_splitter/widgets/bill_list_widget.dart';
import 'package:flutter/material.dart';

import 'package:cash_splitter/widgets/new_bill/new_bill_dialog.dart';

// ignore: must_be_immutable
class OverviewScreen extends StatelessWidget {
  static const routeName = '/overview';

  bool isNew;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("assets/images/Background Image.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: screenSize.height * 0.8,
                child: Column(
                  children: [
                    SizedBox(height: screenSize.height * 0.06),
                    GestureDetector(
                      child: Container(
                        child: Image.asset('assets/images/app-icon.png'),
                        width: screenSize.width * 0.17,
                        height: screenSize.height * 0.17,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.025),
                    BillList(),
                    SizedBox(height: screenSize.height * 0.02),
                  ],
                ),
              ),
              Container(
                height: screenSize.height * 0.09,
                width: screenSize.width * 0.8,
                child: ElevatedButton(
                  child: Text(
                    "New bill",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  onPressed: () => openBillDialog(context),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(98, 65, 234, 1),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
