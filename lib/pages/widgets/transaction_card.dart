import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:face_net_authentication/pages/constants/app_textstyle.dart';
import 'package:face_net_authentication/pages/data/transaction_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;
  TransactionCard({Key key, this.transaction}) : super(key: key);

  /*Future<void> addUser() {
    // Call the user's CollectionReference to add a new user

    return transactionDB
        .add({
          'name': fname.text, // John Doe
          'cnum': cnum.text, // Stokes and Sons
          'cvv': cvv.text,
          'exp': exp.text // 42
        })
        .then((value) => print("User data Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }*/

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color(0XFFDE8D40),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.orangeAccent[200])),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "PAYMENT ID:\n" + transaction.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "AMOUNT:\n" + transaction.amount,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
