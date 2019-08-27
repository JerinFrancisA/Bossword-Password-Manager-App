import 'package:bossword/screens/all_passwords.dart';
import 'package:bossword/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:bossword/custom_widgets/input_box.dart';
import 'package:bossword/custom_widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

var auth = FirebaseAuth.instance;

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

  bool showSpinner = false;

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
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          color: kRedColor,
          child: Center(
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
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          final user = await auth.signInWithEmailAndPassword(
                              email: username.input, password: password.input);
                          if (user != null) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text('Login Successful !'),
                                  contentPadding: EdgeInsets.all(12.0),
                                  contentTextStyle: kInputBoxStyle,
                                  actions: <Widget>[
                                    RaisedButton(
                                      child: Text(
                                        'Yeah, I\'m the boss',
                                        style: kInputBoxStyle.copyWith(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pushNamed(
                                            context, AllPasswords.routeName);
                                      },
                                      color: kInputBoxColor,
                                    ),
                                  ],
                                  backgroundColor: kRedColor,
                                  elevation: 6.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                );
                              },
                            );
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          setState(() {
                            showSpinner = false;
                          });
                          print(e);
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                content: Text('Run away, You\'re not my Boss'),
                                contentPadding: EdgeInsets.all(12.0),
                                contentTextStyle: kInputBoxStyle,
                                actions: <Widget>[
                                  RaisedButton(
                                    child: Text(
                                      'Hehe xD',
                                      style: kInputBoxStyle.copyWith(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    color: kInputBoxColor,
                                  ),
                                ],
                                backgroundColor: kRedColor,
                                elevation: 6.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
