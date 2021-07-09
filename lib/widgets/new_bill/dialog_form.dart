import 'dart:ui';

import 'package:cash_splitter/widgets/new_bill/user_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../hero_dialog_route.dart';
import 'package:cash_splitter/providers/models.dart';

// ignore: must_be_immutable
class DialogForm extends StatelessWidget {
  final enteredNo = TextEditingController();

  final enteredTitle = TextEditingController();

  int peopleNo = 0;

  String billTitle;

  Bill bill = Bill();
  bool errorText = false;

  Color themePurple = Color.fromRGBO(98, 65, 234, 1);

  final GlobalKey<FormState> _formKey1 = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Form(
      key: _formKey1,
      child: Wrap(children: [
        Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "New Bill",
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: TextFormField(
                    controller: enteredTitle,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.place_outlined,
                        color: Colors.blue,
                      ),
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Text is empty';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  // height: screenSize.height * 0.08,
                  // width: screenSize.width * 0.55,
                  margin: EdgeInsets.only(top: screenSize.height * 0.01),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: TextFormField(
                    controller: enteredNo,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Number of people',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.blue,
                        ),
                        errorMaxLines: 2),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'please enter a number';
                      } else if (int.parse(text) < 2) {
                        return 'number is less than 2';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            // padding: const EdgeInsets.symmetric(
            //   horizontal: 10.0,
            //   vertical: 16,
            // ),
            margin: EdgeInsets.only(
                top: screenSize.height * 0.01,
                bottom: screenSize.height * 0.008),
            height: screenSize.height * 0.07,
            width: screenSize.width * 0.4,
            child: ElevatedButton(
              child: Text(
                "New Bill",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onPressed: () {
                if (!_formKey1.currentState.validate()) {
                  return;
                }
                peopleNo = int.parse(enteredNo.text);
                billTitle = enteredTitle.text;
                // _saveForm();

                bill.setTitle(billTitle);
                bill.initParticipants(peopleNo);

                Navigator.of(context).push(
                  HeroDialogRoute(
                    builder: (context) {
                      return AddBillPopupCard(bill, peopleNo);
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(98, 65, 234, 1),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),
        ]),
      ]),
    );
  }
}

// ignore: must_be_immutable
class AddBillPopupCard extends StatelessWidget {
  final Bill bill;
  int peopleNo;
  AddBillPopupCard(this.bill, this.peopleNo);

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(ctx).size;
    final nextController = SwiperController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        // height: screenSize.height,
        // width: screenSize.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/blurred.png"),
            fit: BoxFit.cover,
          ),
        ),
        // child: Center(

        // width: screenSize.width * 0.7,
        // height: screenSize.height * 0.5,
        child: Swiper(
          loop: false,
          index: 0,
          controller: nextController,
          // scale: peopleNo.toDouble(),
          control: SwiperControl(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          ),

          scrollDirection: Axis.horizontal,
          pagination: SwiperPagination(),
          itemCount: peopleNo,
          itemBuilder: (ctx, index) {
            return UserInput(
              peopleNo,
              index,
              nextController,
              bill,
            );
          },
        ),
      ),
    );
  }
}
