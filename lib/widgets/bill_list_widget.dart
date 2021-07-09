import 'package:cash_splitter/providers/models.dart';
import 'package:cash_splitter/screens/final_screen.dart';
import 'package:flutter/material.dart';

import '../helpers/sql_helper.dart';
import '../providers/models.dart';

class BillList extends StatefulWidget {
  @override
  _BillListState createState() => _BillListState();
}

class _BillListState extends State<BillList> {
  SqlHelper helper;

  @override
  void didChangeDependencies() {
    getBills();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // var billsData = Provider.of<Bills>(context);

    return FutureBuilder(
      future: getBills(),
      // billsData.fetchBills(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          List<Bill> bills = snapshot.data;

          return Container(
            height: bills.length <= 4
                ? (screenSize.height * (bills.length * 0.1))
                : screenSize.height * 0.5,
            color: Colors.white.withOpacity(0.5),
            width: screenSize.width,
            child: ListView.builder(
              padding: EdgeInsets.only(top: 1),
              itemCount: bills.length,
              itemBuilder: (ctx, index) {
                return Container(
                  height: screenSize.height * 0.1,
                  child: Dismissible(
                    key: Key(bills[index].id),
                    background: Container(color: Colors.red),
                    onDismissed: (direction) async {
                      await helper.deleteBill(bills[index].id);

                      setState(() {
                        getBills();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(milliseconds: 600),
                          content: Row(children: [
                            Text(
                              "${bills[index].title}  ",
                              style: TextStyle(color: Colors.amber),
                            ),
                            Text(
                              "dismissed ",
                              style: TextStyle(color: Colors.white),
                            )
                          ]),
                        ),
                      );
                    },
                    child: ListTile(
                      onTap: () async {
                        bills[index].isNew = true;
                        bills[index].participants =
                            await helper.getParticipants(bills[index]);
                        Navigator.of(context).pushNamed(
                          FinalScreen.routeName,
                          arguments: {
                            'bill': bills[index],
                          },
                        );
                      },
                      trailing: Container(
                        height: double.infinity,
                        // screenSize.height * 0.5,
                        // color: Colors.blue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Container(
                                margin: EdgeInsets.only(top: 5),
                                // color: Colors.black,
                                width: screenSize.width * 0.2,
                                height: screenSize.height * 0.06,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 35,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    Text(
                                      '${bills[index].pno}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
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
                              '${bills[index].total.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      title: Text(
                        "${bills[index].title}",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Future<List<Bill>> getBills() async {
    helper = SqlHelper.instance;
    List<Bill> bills = await helper.getBills();
    return bills ?? [];
  }
}
