import 'package:cash_splitter/providers/models.dart';
import 'package:flutter/material.dart';

const String _heroAddTodo = 'add-todo-hero';

vatDialog(BuildContext context, Bill bill) {
  final screenSize = MediaQuery.of(context).size;

  final enteredVat = TextEditingController();
  final enteredServices = TextEditingController();
  enteredVat.text = '0';

  enteredServices.text = '0';
  final GlobalKey<FormState> _formKey1 = GlobalKey();

  return showDialog(
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
            height: screenSize.height * 0.45,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                    child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                  ),
                  child: Container(
                    width: screenSize.width * 0.3,
                    height: screenSize.height * 0.09,
                    child: Image.asset('assets/images/dialog_taxes.png'),
                  ),
                )),
                Form(
                  key: _formKey1,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'VAT :',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 70,
                            ),
                            VatInputField(enteredVat),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '''EXTRA\nSERVICES : ''',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            VatInputField(enteredServices),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: screenSize.height * 0.1,
                          width: screenSize.width * 0.5,
                          padding: EdgeInsets.only(top: 20),
                          child: ElevatedButton(
                            child: Text(
                              "Next",
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            ),
                            onPressed: () {
                              print(enteredVat.text);

                              bill.vat = double.parse(enteredVat.text) / 100;
                              bill.service = double.parse(enteredServices.text);
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
      );
    },
  );
}

class VatInputField extends StatelessWidget {
  final TextEditingController enteredTextController;
  VatInputField(this.enteredTextController);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height * 0.07,
      width: screenSize.width * 0.3,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        controller: enteredTextController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          // helperText: "*enter a percentage",
          // labelText: 'QTY',
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
    );
  }
}
