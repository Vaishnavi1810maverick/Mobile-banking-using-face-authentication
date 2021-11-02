import 'package:flutter/material.dart';
import 'package:face_net_authentication/pages/constants/color_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Widget myCards = CardData(
  cardHolderName: "Jane Doe",
  cardNumber: "**** **** **** 1234",
  expDate: "10/23",
  cvv: "555",
);

class CardData extends StatelessWidget {
  String cardHolderName;
  String cardNumber;
  String expDate;
  String cvv;
  Color cardColor;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  CardData({
    this.cardHolderName,
    this.cardNumber,
    this.cvv,
    this.expDate,
    this.cardColor,
  });

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
