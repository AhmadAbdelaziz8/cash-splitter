import 'package:cash_splitter/providers/models.dart';
import 'package:flutter/material.dart';

import './choose_participant.dart';

const String _heroAddTodo = 'add-todo-hero';

String billTitle;

addItemDialog(BuildContext context, Bill bill,) async {
  final screenSize = MediaQuery.of(context).size;

  final enteredNo = TextEditingController();
  final enteredTitle = TextEditingController();
  final enteredQty = TextEditingController();
  print(bill.participants);

  final GlobalKey<FormState> _formKey1 = GlobalKey();
  int qty = 1;
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return Hero(
        tag: _heroAddTodo,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            padding: EdgeInsets.only(bottom: 15),
            width: screenSize.width * 1,
            height: screenSize.height * 0.6,
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: screenSize.width * 0.3,
                    height: screenSize.height * 0.09,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: screenSize.width * 0.2,
                          height: screenSize.height * 0.08,
                          child: Image.asset('assets/images/shopping.png'),
                        ),
                        Text(
                          '#1',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: _formKey1,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: screenSize.width * 0.7,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: SingleChildScrollView(
                              child: TextFormField(
                                controller: enteredTitle,
                                decoration: InputDecoration(
                                  labelText: 'Item name',
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
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Text is empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: screenSize.width * 0.7,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextFormField(
                              controller: enteredNo,
                              keyboardType: TextInputType.number,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Text is empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'price',
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
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: screenSize.height * 0.01),
                            height: screenSize.height * 0.1,
                            width: screenSize.width * 0.3,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: TextFormField(
                              controller: enteredQty,
                              keyboardType: TextInputType.number,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Text is empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'QTY',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
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
                            ),
                          ),
                          Container(
                            height: screenSize.height * 0.13,
                            width: screenSize.width * 0.5,
                            padding: EdgeInsets.only(top: 20),
                            child: ElevatedButton(
                              child: Text(
                                "Next",
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                              onPressed: () async {
                                print(bill.participants);
                                if (!_formKey1.currentState.validate()) {
                                  return;
                                }
                                String title = enteredTitle.text;
                                double price = double.parse(enteredNo.text);
                                qty = int.parse(enteredQty.text);
                                Item item = Item(title, qty, price);

                                await chooseParticipantsDialog(
                                    context, item, bill);
                                Navigator.of(context).pop();
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
