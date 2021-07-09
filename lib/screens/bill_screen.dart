import 'package:cash_splitter/widgets/new_item_vat/add_item_dialog.dart';
import 'package:cash_splitter/widgets/new_item_vat/vat_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cash_splitter/providers/models.dart';
import 'package:cash_splitter/screens/final_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import 'new_bill/new_bill_dialog.dart';

import '../providers/models.dart';

class BillScreen extends StatefulWidget {
  static const routeName = '/bill-screen';

  @override
  _BillScreenState createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  // @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Bill>;

    Bill bill = routeArgs['bill'];
    String billTitle = bill.title;
    int itemsLength = bill.items.length;
    // int peopleNo = bill.participants.length;
    // bill.items = [];

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bill-image.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          child: Column(
            children: [
              Container(
                // width: screenSize.width,
                height: screenSize.height * 0.85,
                // color: Colors.black,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 60.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/bill-icon.png',
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          '$billTitle',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.06,
                  ),
                  // ItemList(
                  //   bill,
                  // ),
                  bill.items.isEmpty || itemsLength == 0
                      ? Container()
                      : Container(
                          height: itemsLength < 4
                              ? screenSize.height * (itemsLength * 0.1)
                              : screenSize.height * 0.5,
                          color: Colors.white.withOpacity(0.5),
                          child: ListView.builder(
                            padding: EdgeInsets.only(top: 1),
                            itemCount: itemsLength,
                            itemBuilder: (_, index) {
                              // return Card(
                              // child:
                              return Column(
                                children: [
                                  Container(
                                    height: screenSize.height * 0.1,
                                    child: Dismissible(
                                      onDismissed: (direction) async {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            duration:
                                                Duration(milliseconds: 600),
                                            content: Row(children: [
                                              Text(
                                                "${bill.items[index].name}  ",
                                                style: TextStyle(
                                                    color: Colors.amber),
                                              ),
                                              Text(
                                                "is dismissed ",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ]),
                                          ),
                                        );
                                        setState(() {
                                          bill.items.removeAt(index);
                                        });
                                      },
                                      background: Container(
                                        color: Colors.red,
                                        // child: Padding(
                                        // padding: const EdgeInsets.all(15),
                                        child: Icon(Icons.delete,
                                            color: Colors.white),
                                        // ),
                                      ),
                                      key: Key(bill.items[index].id),
                                      child: ListTile(
                                        trailing: Container(
                                          height: double.infinity,
                                          // color: Colors.black,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Container(
                                                  // margin:
                                                  //     EdgeInsets.only(top: 5),
                                                  width:
                                                      screenSize.width * 0.20,
                                                  height:
                                                      screenSize.height * 0.042,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.person,
                                                        size: 32,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                      // SizedBox(
                                                      //   height: 100,
                                                      // ),
                                                      Text(
                                                        '${bill.items[index].participants.length}',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              // SizedBox(
                                              //   height: 10,
                                              // ),
                                              Text(
                                                '${bill.items[index].totalPrice}',
                                                style: TextStyle(
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        title: Text(
                                          "${bill.items[index].name}",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          "${bill.items[index].quantity}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Divider(
                                  //   thickness: 2,
                                  // )
                                ],
                              ); // );
                            },
                          ),
                        ),
                ]),
              ),
              Container(
                height: screenSize.height * 0.15,
                color: Colors.white.withOpacity(0.5),
                //  Colors.white.withOpacity(0.5),
                child:
                    // BottomRow(bill)
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        vatDialog(context, bill);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 30.0,
                          top: 25,
                        ),
                        child: Column(
                          children: [
                            Flexible(
                                child: Image.asset('assets/images/taxes.png')),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'TAXES',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await addItemDialog(
                          context,
                          bill,
                        );
                        setState(() {
                          itemsLength = bill.items.length;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 30.0,
                          right: 30,
                          top: 20,
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 7),
                              child: Icon(
                                FontAwesomeIcons.plusCircle,
                                color: Theme.of(context).primaryColor,
                                size: 45,
                              ),
                            ),
                            Text(
                              'Add Item',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // print(bill.participants);

                        if (bill.items.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(milliseconds: 450),
                              content: Row(children: [
                                Text(
                                  "No items added yet",
                                  style: TextStyle(color: Colors.amber),
                                ),
                              ]),
                            ),
                          );
                          return;
                        }
                        print(bill.items);

                        // bill.calculateBills();
                        bill.subTotal = 0;
                        bill.participants.forEach((element) {
                          element.bill = 0;
                        });

                        bill.items.forEach((item) {
                          int n = item.participants.length;
                          bill.subTotal += item.totalPrice;
                          item.participants.forEach((participant) {
                            participant.bill += item.totalPrice / n;
                          });
                        });

                        int b = bill.participants.length;
                        bill.participants.forEach((partcipant) {
                          partcipant.bill += (bill.service / b) +
                              (partcipant.bill * bill.vat) +
                              ((bill.service * bill.vat) / b);
                        });

                        bill.total = bill.subTotal +
                            bill.service +
                            (bill.vat * (bill.subTotal + bill.service));

                        Navigator.of(context).pushNamed(
                          FinalScreen.routeName,
                          arguments: {
                            'bill': bill,
                          },
                        );
                        // bill.items = List.empty();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 30.0,
                          right: 30,
                          top: 20,
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 7),
                              child: Icon(
                                FontAwesomeIcons.checkCircle,
                                size: 45,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              'Finish',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        // ),
        // ]),
      ),
      // ),
    );
  }
}
