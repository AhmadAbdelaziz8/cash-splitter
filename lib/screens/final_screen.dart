import 'package:cash_splitter/helpers/sql_helper.dart';
import 'package:cash_splitter/screens/overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../providers/models.dart';

// ignore: must_be_immutable
class FinalScreen extends StatelessWidget {
  static const routeName = '/final-screen';
  SqlHelper helper;

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Bill>;

    Bill bill = routeArgs['bill'];

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
          height: screenSize.height,
          width: screenSize.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/final-screen.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            height: screenSize.height,
            width: screenSize.width,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: screenSize.height * 0.04,
                      bottom: screenSize.height * 0.03,
                    ),
                    color: Colors.white.withOpacity(0.5),
                    height: screenSize.height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/bill-icon.png'),
                        SizedBox(
                          width: screenSize.width * 0.03,
                        ),
                        Text(
                          '${bill.title}',
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: screenSize.height * 0.2,
                    child: Column(
                      // mainAxisAlignment: ,
                      children: [
                        Flexible(child: TextRow(bill.subTotal, 'Subtotal')),
                        TextRow(
                            bill.vat * (bill.subTotal + bill.service), 'Vat'),
                        TextRow(bill.service, 'Extra services'),
                        Divider(
                          color: Colors.grey,
                          endIndent: 80,
                          indent: 80,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: screenSize.width * 0.04),
                                child: Text(
                                  'Total:',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: screenSize.width * 0.03),
                                child: Text(
                                  '\$${bill.total.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: screenSize.height * 0.03,
                      bottom: screenSize.height * 0.05,
                    ),
                    color: Colors.white.withOpacity(0.5),
                    height: screenSize.height * 0.4,
                    child: ListView.builder(
                      itemCount: bill.participants.length,
                      itemBuilder: (ctx, index) {
                        return Column(children: [
                          ListTile(
                            leading: Text(
                              '${bill.participants[index].name}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Text(
                              '\$ ${bill.participants[index].bill.toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Divider(
                            color: Colors.white70,
                            thickness: 0.6,
                          ),
                        ]);
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (bill.isNew) {
                        Navigator.of(context).pop();
                        // Navigator.popUntil(context,
                        // ModalRoute.withName(OverviewScreen.routeName));
                      } else {
                        bill.pno = bill.participants.length;
                        bill.id = DateTime.now().toString();
                        await SqlHelper.instance.insertBill(bill);

                        bill.participants.forEach((element) {
                          element.billId = bill.id;
                          SqlHelper.instance.insertParticipants(element);
                        });
                        Navigator.of(context)
                            .pushReplacementNamed(OverviewScreen.routeName);

                        // Navigator.popUntil(context, ModalRoute.withName('/'));
                        // bill.items = null;
                      }
                    },
                    child: Icon(
                      FontAwesomeIcons.checkCircle,
                      color: Colors.green,
                      size: 50,
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

class TextRow extends StatelessWidget {
  final text;
  final double number;
  TextRow(this.number, this.text);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(left: screenSize.width * 0.04),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: screenSize.width * 0.03),
          child: Text(
            '\$${number.toStringAsFixed(2)}',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
