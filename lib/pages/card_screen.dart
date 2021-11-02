import 'package:face_net_authentication/pages/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face_net_authentication/pages/constants/app_textstyle.dart';
import 'package:face_net_authentication/pages/constants/color_constants.dart';
import 'package:face_net_authentication/pages/data/card_data.dart';
import 'package:face_net_authentication/pages/widgets/my_card.dart';
import 'home.dart';
import 'package:alert_dialog/alert_dialog.dart';

Widget myCards = CardData(
  cardHolderName: "",
  cardNumber: "",
  expDate: "",
  cvv: "",
);

TextEditingController fname = new TextEditingController();
TextEditingController cnum = new TextEditingController();
TextEditingController cvv = new TextEditingController();
TextEditingController exp = new TextEditingController();

class CardScreen extends StatelessWidget {
  CardScreen({Key key}) : super(key: key);

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> updateUser() {
    String str = "";

    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["user"] == fname.text) {
          str = doc.id.toString();
          return users
              .doc(str)
              .update({
                'name': fname.text,
                'cnum': cnum.text,
                'exp': exp.text,
                'cvv': cvv.text,
              })
              .then((value) => print("User Updated"))
              .catchError((error) => print("Failed to update user: $error"));
        }
      });
    });
    myCards = CardData(
      cardHolderName: fname.text,
      cardNumber: cnum.text,
      expDate: exp.text,
      cvv: cvv.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection

    return Scaffold(
      backgroundColor: Color(0XFFE6EFF9),
      appBar: AppBar(
        backgroundColor: Color(0XFF335098),
        centerTitle: true,
        title: Text(
          "My Cards",
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("UPDATING DETAILS",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 30.0,
          ),
          Text("Update your card details to send Money!",
              style: TextStyle(fontSize: 20)),
          Image.asset('assets/Card.png'),
          SizedBox(
            height: 40.0,
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: ListView.separated(
                shrinkWrap: true,
                itemCount: 1,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 20,
                  );
                },
                itemBuilder: (context, index) {
                  return MyCard(
                    card: myCards,
                  );
                }),
          ),
          SizedBox(height: 10),
          AppButton(
            text: "Update Card",
            // style: ApptextStyle.LISTTILE_TITLE,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20.0)), //this right here
                      child: Container(
                        height: 350,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text("DETAILS"),
                              ),
                              TextField(
                                controller: fname,
                                decoration: InputDecoration(
                                  hintText: "Name",
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blueGrey),
                                  ),
                                ),
                              ),
                              TextField(
                                controller: cnum,
                                decoration: InputDecoration(
                                  hintText: "Card Number",
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blueGrey),
                                  ),
                                ),
                              ),
                              TextField(
                                controller: exp,
                                decoration: InputDecoration(
                                  hintText: "Expiration Date",
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blueGrey),
                                  ),
                                ),
                              ),
                              TextField(
                                controller: cvv,
                                decoration: InputDecoration(
                                  hintText: "CVV",
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blueGrey),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              SizedBox(
                                width: 320.0,
                                child: RaisedButton(
                                  onPressed: () {
                                    updateUser;
                                    alert(context,
                                        title: Text('Update'),
                                        content: Text(
                                            "Updated Card Details Succesfully!"));
                                  },
                                  child: Text(
                                    "Update",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: const Color(0xFF1BC0C5),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
