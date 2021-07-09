import 'package:cash_splitter/providers/models.dart';
import 'package:flutter/material.dart';

const String _heroAddTodo = 'add-todo-hero';

String billTitle;

chooseParticipantsDialog(BuildContext context, Item item, Bill bill) async {
  List<bool> _checked = List<bool>.filled(bill.participants.length, false);
  bool _allChecked = false;

  final screenSize = MediaQuery.of(context).size;
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Hero(
            tag: _heroAddTodo,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              // contentPadding: EdgeInsets.only(top: 10.0),
              content: Container(
                // padding: EdgeInsets.only(bottom: 15),
                width: screenSize.width,
                height: screenSize.height * 0.7,
                // child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        height: screenSize.height * 0.085,
                        // padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Container(
                                child: Container(
                                  // color: Colors.red,
                                  // height: screenSize.height * 0.012,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: screenSize.width * 0.2,
                                        // height: screenSize.height * 0.08,
                                        // margin: const EdgeInsets.only(bottom: 8.0),
                                        child: Image.asset(
                                            'assets/images/shopping.png'),
                                      ),
                                      Text(
                                        // "aa",
                                        "#${item.name}", // '#${index + 1}',
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.only(bottom: screenSize.height * 0.08),
                      // color: Colors.black,
                      width: screenSize.width * 1,
                      height: screenSize.height * 0.48,
                      child: Column(children: [
                        Container(
                          // color: Colors.amber,
                          height: screenSize.height * 0.07,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: CheckboxListTile(
                            title: Text(
                              'select all',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            value: _allChecked,
                            onChanged: (bool value) {
                              setState(() {
                                _allChecked = value;
                                for (int i = 0; i < _checked.length; i++) {
                                  _checked[i] = _allChecked;
                                }
                              });
                            },
                          ),
                        ),

                        // Divider(
                        //   color: Colors.black,
                        //   endIndent: 80,
                        //   indent: 80,
                        //   thickness: 1,
                        // ),
                        Container(
                          height: screenSize.height * 0.38,
                          child: ListView.builder(
                            itemCount: bill.participants.length,
                            itemBuilder: (_, index) {
                              return CheckboxListTile(
                                title: Text(
                                  '${index + 1}. ${bill.participants[index].name}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                value: _checked[index],
                                onChanged: (bool value) {
                                  setState(() {
                                    _checked[index] = value;
                                    print(value);
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ]),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2),
                      height: screenSize.height * 0.08,
                      width: screenSize.width * 0.5,
                      child: ElevatedButton(
                        child: Text(
                          "done",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        onPressed: () {
                          for (int i = 0; i < bill.participants.length; i++) {
                            if (_checked[i])
                              item.addParticipant(bill.participants[i]);
                          }
                          // print(item.participants);
                          item.id = DateTime.now().toString();
                          try {
                            print('${bill.items.length}');
                            bill.items.add(item);
                            // bill.addItem(item);
                          } catch (error) {
                            print(error);
                            throw (error);
                          }

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
            // ),??
          );
        },
      );
    },
  );
}
