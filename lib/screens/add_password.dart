import 'package:bossword/custom_widgets/input_box.dart';
import 'package:bossword/custom_widgets/button.dart';
import 'package:bossword/utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'all_passwords.dart';

class AddPassword extends StatefulWidget {
  static const routeName = 'AddPassword';

  @override
  _AddPasswordState createState() => _AddPasswordState();
}

class _AddPasswordState extends State<AddPassword> {
  final _fireStore = Firestore.instance;
  var website = InputBox(
    text: 'Website Name',
    icon: Icon(
      Icons.computer,
      size: 24.0,
    ),
    textCapitalization: TextCapitalization.words,
  );

  var username = InputBox(
    text: 'Username/ID',
    icon: Icon(
      Icons.account_circle,
      size: 24.0,
    ),
  );

  var password = InputBox(
    text: 'Password',
    icon: Icon(
      Icons.vpn_key,
      size: 24.0,
    ),
  );

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          color: kRedColor,
          child: ListView(
            children: [
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'Add new ID and Password',
                    style: kInputBoxStyle,
                  ),
                  website,
                  username,
                  password,
                  Button(
                    text: 'ADD',
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      await _fireStore.collection('passwords').document('${website.input??'errDoc'}').setData(
                        {
                          'website': website.input,
                          'username': username.input,
                          'password': password.input,
                        },
                      );
                      setState(() {
                        showSpinner = false;
                      });
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return AlertDialog(
                            content: Text('Added successfully'),
                            contentPadding: EdgeInsets.all(12.0),
                            contentTextStyle: kInputBoxStyle,
                            actions: <Widget>[
                              RaisedButton(
                                child: Text(
                                  'Cool',
                                  style: kInputBoxStyle.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.popAndPushNamed(
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
