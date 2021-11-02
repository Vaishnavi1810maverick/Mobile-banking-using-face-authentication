import 'package:face_net_authentication/pages/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:face_net_authentication/pages/constants/color_constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import 'package:face_net_authentication/pages/send_screen.dart';
import 'card_screen.dart';
import 'package:face_net_authentication/pages/widgets/transaction_card.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CardScreen(),
    SendScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.home,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.creditCard), label: "Cards"),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.cog), label: "Send"),
            // BottomNavigationBarItem(
            //    icon: Icon(FontAwesomeIcons.chartBar), label: "Overview")
          ],
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}
