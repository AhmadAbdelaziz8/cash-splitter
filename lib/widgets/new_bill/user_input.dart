import 'dart:ui';

import 'package:cash_splitter/screens/bill_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:cash_splitter/providers/models.dart';

// ignore: must_be_immutable
class UserInput extends StatelessWidget {
  final int peopleNo;
  final Bill bill;
  final SwiperController next;
  final int index;
  UserInput(this.peopleNo, this.index, this.next, this.bill);
  // bool lastElement =  index == peopleNo - 1;
  final GlobalKey<FormState> _formKey2 = GlobalKey();
  var enteredName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          contentPadding: EdgeInsets.only(
            top: 10.0,
          ),
          content: Container(
            width: screenSize.width * 0.5,
            height: screenSize.height * 0.45,
            // child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Icon(
                          Icons.person_outline_sharp,
                          size: 52,
                        ),
                      ),
                      Text(
                        '#${index + 1}',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Form(
                  key: _formKey2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    // child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: screenSize.width * 0.7,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextFormField(
                            controller: enteredName,
                            decoration: InputDecoration(
                              labelText: 'participant name',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.green,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                              ),
                            ),
                            // keyboardType: TextInputType.name,
                            onFieldSubmitted: (_) {
                              bill.participants[index].name = enteredName.text;
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Text is empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        // ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.045),
                    // padding: EdgeInsets.only(top: 20, bottom: 50),
                    height: screenSize.height * 0.09,
                    width: screenSize.width * 0.5,
                    child: ElevatedButton(
                      // autofocus: true,
                      child: Text(
                        index == peopleNo - 1 ? "done" : "Next",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      onPressed: () {
                        if (!_formKey2.currentState.validate()) {
                          return;
                        }
                        if (index == peopleNo - 1) {
                          bill.participants[index].name = enteredName.text;
                          bill.items = [];
                          Navigator.of(context).pushReplacementNamed(
                              BillScreen.routeName,
                              arguments: {'bill': bill});
                          // print(bill.participants);
                        } else {
                          bill.participants[index].name = enteredName.text;

                          next.next(animation: true);
                        }
                      },

                      style: ElevatedButton.styleFrom(
                        primary: index == peopleNo - 1
                            ? Colors.green
                            : Color.fromRGBO(98, 65, 234, 1),
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }
}
