import 'package:alert_dialog/alert_dialog.dart';
import 'package:face_net_authentication/pages/db/database.dart';
import 'package:face_net_authentication/pages/send_screen.dart';
import 'package:flutter/material.dart';
import 'package:face_net_authentication/pages/constants/app_textstyle.dart';
import 'package:face_net_authentication/pages/constants/color_constants.dart';
import 'package:face_net_authentication/pages/data/card_data.dart';
import 'package:face_net_authentication/pages/widgets/auth-action-button.dart';
import 'package:face_net_authentication/pages/data/transaction_data.dart';
import 'package:face_net_authentication/pages/widgets/my_card.dart';
import 'package:face_net_authentication/pages/card_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face_net_authentication/pages/widgets/transaction_card.dart';
import 'home.dart';
import 'package:face_net_authentication/pages/send_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);
  Widget myCards = CardData(
    cardHolderName: "Jane Doe",
    cardNumber: "****  ****  ****  1234",
    cvv: "**4",
    expDate: "12/21",
    cardColor: kPrimaryColor,
  );

  @override
  Widget build(BuildContext context) {
    myCards = CardData(
      cardHolderName: fname.text,
      cardNumber: cnum.text,
      expDate: cvv.text,
      cvv: exp.text,
    );
    return Scaffold(
      backgroundColor: Color(0XFFE6EFF9),
      appBar: AppBar(
        backgroundColor: Color(0XFF335098),
        centerTitle: true,
        title: Text(
          "Secure Bank",
          style: TextStyle(
            fontFamily: "Poppins",
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
                size: 27,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              }),
        ],
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'WELCOME! ',
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  'MY CARD:',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
              ),
              Container(
                height: 200,
                child: ListView.separated(
                    physics: ClampingScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 10,
                      );
                    },
                    itemCount: 1,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return MyCard(
                        card: myCards,
                      );
                    }),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                child: Text(
                  'OPTIONS:',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                      child: MaterialButton(
                        height: 80.0,
                        minWidth: 80.0,
                        color: Color(0XFF335098),
                        textColor: Colors.white,
                        child: Text('Transfer \n Money'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SendScreen()),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                      child: MaterialButton(
                        height: 80.0,
                        minWidth: 80.0,
                        color: Color(0XFF335098),
                        textColor: Colors.white,
                        child: Text('Account \n Details'),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('users')
                              .get()
                              .then((QuerySnapshot querySnapshot) {
                            querySnapshot.docs.forEach((doc) {
                              if (doc["user"] == fname.text) {
                                alert(context,
                                    content: Text(
                                        "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t" +
                                            "USER DETAILS\n\n\nNAME:  " +
                                            fname.text +
                                            "\n\n" +
                                            "CARD NUMBER: " +
                                            cnum.text +
                                            "\n\n" +
                                            "CVV: " +
                                            "***" +
                                            "\n\n" +
                                            "EXPIRY DATE: " +
                                            exp.text +
                                            "\n\n" +
                                            "PREV. TRANSACTION ID: " +
                                            doc['transaction'] +
                                            "\n\n" +
                                            "PREV TRANSACTION AMOUNT: " +
                                            doc['amount']));
                              }
                            });
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                      child: MaterialButton(
                        height: 80.0,
                        minWidth: 80.0,
                        color: Color(0XFF335098),
                        textColor: Colors.white,
                        child: Text('Update Card \n Details'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CardScreen()),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Text(
                  'MY RECENT TRANSACTION:',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ListView.separated(
                  itemCount: 1,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 30,
                    );
                  },
                  itemBuilder: (context, index) {
                    return TransactionCard(transaction: myTransactions);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
