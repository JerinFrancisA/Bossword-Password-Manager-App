import 'package:bossword/screens/all_passwords.dart';
import 'package:bossword/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:bossword/custom_widgets/input_box.dart';
import 'package:bossword/custom_widgets/button.dart';
import 'package:flutter_icons/flutter_icons.dart';

class BossLogin extends StatefulWidget {
  static const routeName = 'BossLogin';

  @override
  _BossLoginState createState() => _BossLoginState();
}

class _BossLoginState extends State<BossLogin> {
  var username = InputBox(
    text: 'Boss ID',
    hintText: 'Enter Boss ID',
    icon: Icon(
      Icons.supervised_user_circle,
      size: 24.0,
    ),
  );

  var password = InputBox(
    text: 'Boss-Word',
    hintText: 'Enter Boss Password',
    icon: Icon(
      Icons.vpn_key,
      size: 24.0,
    ),
    obscureText: true,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Boss Word',
            style: kInputBoxStyle,
          ),
          titleSpacing: 2.5,
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: kRedColor,
        ),
        body: Center(
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 26.0,
                  ),
                  Column(
                    children: <Widget>[
                      username,
                      password,
                    ],
                  ),
                  Button(
                    text: 'GO BOSSMODE',
                    onPressed: () {
                      print('${username.input} and ${password.input}');
                      Navigator.pushNamed(context, AllPasswords.routeName);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
