import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:alert_dialog/alert_dialog.dart';
import 'package:face_net_authentication/pages/db/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face_net_authentication/pages/widgets/transaction_card.dart';
import 'package:face_net_authentication/pages/data/transaction_data.dart';

String pid = "";
TextEditingController textEditingController = new TextEditingController();
Widget myTransactions = TransactionModel(
    name: "No Transactions", color: Colors.green[100], amount: "0");

class SendScreen extends StatefulWidget {
  @override
  _SendScreen createState() => _SendScreen();
}

class _SendScreen extends State<SendScreen> {
  Razorpay razorpay;

  @override
  void initState() {
    super.initState();

    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_jlLZyLdKjOI7k6",
      "amount": num.parse(textEditingController.text) * 100,
      "name": "Sample App",
      "description": "Payment for the some random product",
      "prefill": {"contact": "7550280906", "email": "abc@gmail.com"},
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    print("Payment success");
    pid = response.paymentId.toString();
    alert(context, title: Text('Alert'), content: Text("Payment Succesful!"));
    setState(() {
      myTransactions = TransactionModel(
          name: pid,
          color: Colors.green[100],
          amount: textEditingController.text);
    });
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .doc(val)
        .update({'transaction': pid, 'amount': textEditingController.text})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  void handlerErrorFailure() {
    print("Pament error");
    alert(context,
        title: Text('Alert'), content: Text("Payment Failed! Try again."));
  }

  void handlerExternalWallet() {
    print("External Wallet");
    Fluttertoast.showToast(msg: "External Wallet");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFE6EFF9),
      appBar: AppBar(
        backgroundColor: Color(0XFF335098),
        title: Text("Transfer"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            children: [
              Text("QUICK TRANSFER",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 30.0,
              ),
              Text("Transfer money in the way that best suits you!",
                  style: TextStyle(fontSize: 20)),
              SizedBox(
                height: 50.0,
              ),
              Image.asset('assets/transfer.png'),
              SizedBox(
                height: 40.0,
              ),
              Text(
                "Enter the amount to be transferred:",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(hintText: "amount"),
              ),
              SizedBox(
                height: 12,
              ),
              RaisedButton(
                color: Color(0xFFDE8D40),
                child: Text(
                  "Quick Send",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  openCheckout();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
