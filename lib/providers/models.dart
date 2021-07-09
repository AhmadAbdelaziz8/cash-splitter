import 'package:cash_splitter/widgets/new_bill/new_bill_dialog.dart';
import 'package:flutter/material.dart';

class Participant {
  int id;
  String name;
  double bill = 0;
  String billId;

  Participant() {
    this.name = null;
  }

  void setName(String name) {
    this.name = name;
  }

  Map<String, dynamic> toMap() {
    return {'pid': id, 'pname': name, 'pbill': bill, 'pbillId': billId};
  }

  Participant.fromMap(Map<String, dynamic> map) {
    id = map['pid'];
    name = map['pname'];
    bill = map['pbill'];
    billId = map['pbillId'];
  }
}

class Item {
  @required
  String name;
  int quantity;
  List<Participant> participants = [];
  double price;
  double totalPrice;
  String id;

  Item(name, quantity, price) {
    this.name = name;
    this.quantity = quantity;
    this.price = price;
    this.totalPrice = quantity * price;
  }

  void addParticipant(Participant newParticipant) {
    participants.add(newParticipant);
  }

  // String toString() {
  //   return '''Name: ${this.name}, QTY: ${this.quantity}, PRICE: ${this.price}\n
  //   ITEM PARTICIPANTS: ${this.participants}''';
  // }
}

class Bill {
  String id;
  String title;
  double subTotal = 0;
  double total = 0; //total bill, initialized as 0
  List<Participant> participants; //the participants, initialized in constructor
  List<Item> items = []; //the items
  double vat = 0; //taxes perc
  double service = 0;
  int pno; //services perc
  bool isNew = false;

  Bill() {
    this.title = "None";
  }

  void setTitle(String title) {
    this.title = title;
  }

  void initParticipants(int numberOfParticipants) {
    participants =
        new List.generate(numberOfParticipants, (_) => Participant());
    peopleNo = participants.length;
  }

  void calculateBills() {
    this.subTotal = 0;
    this.participants.forEach((element) {
      element.bill = 0;
    });

    this.items.forEach((item) {
      int n = item.participants.length;
      this.subTotal += item.totalPrice;
      item.participants.forEach((participant) {
        participant.bill += item.totalPrice / n;
      });
    });

    int b = bill.participants.length;
    this.participants.forEach((partcipant) {
      partcipant.bill += (service / b) +
          (partcipant.bill * bill.vat) +
          ((service * bill.vat) / b);
    });

    this.total =
        this.subTotal + this.service + (this.vat * (subTotal + service));
  }

  Bill.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    total = map['total'];
    subTotal = map['subtotal'];
    vat = map['vat'];
    service = map['service'];
    pno = map['pno'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'total': total,
      'subtotal': subTotal,
      'vat': vat,
      'service': service,
      'pno': pno,
    };
  }
}
