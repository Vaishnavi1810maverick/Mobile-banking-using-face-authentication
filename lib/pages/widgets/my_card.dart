import 'package:flutter/material.dart';
import 'package:face_net_authentication/pages/constants/app_textstyle.dart';
import 'package:face_net_authentication/pages/constants/color_constants.dart';
import 'package:face_net_authentication/pages/data/card_data.dart';

class MyCard extends StatelessWidget {
  final CardData card;
  const MyCard({Key key, this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 200,
      width: 350,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CARD NAME",
                    style: ApptextStyle.MY_CARD_TITLE,
                  ),
                  Text(
                    card.cardHolderName,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Text(
                card.cardNumber,
                style: ApptextStyle.MY_CARD_SUBTITLE,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "EXP DATE",
                        style: ApptextStyle.MY_CARD_TITLE,
                      ),
                      Text(
                        card.expDate,
                        style: ApptextStyle.MY_CARD_SUBTITLE,
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CVV NUMBER",
                        style: ApptextStyle.MY_CARD_TITLE,
                      ),
                      Text(
                        card.cvv,
                        style: ApptextStyle.MY_CARD_SUBTITLE,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
