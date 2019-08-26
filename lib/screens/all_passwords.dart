import 'package:flutter/material.dart';
import 'package:bossword/utilities/constants.dart';

class AllPasswords extends StatelessWidget {
  final passwords = ['a', 's', 'g', 'j', 'r', 'b'];
  static const routeName = 'AllPasswords';

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
        body: ListView.builder(
          itemCount: passwords.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                dense: true,
                leading: Icon(Icons.lock_outline),
                title: Column(
                  children: <Widget>[
                    Text(
                      'xyz website',
                      style: kInputBoxStyle,
                    ),
                    Text(
                      'Username : ${passwords[index]}',
                      style: kInputBoxStyle,
                    ),
                    Text(
                      'Password : ${passwords[index]}',
                      style: kInputBoxStyle,
                    ),
                  ],
                ),
                contentPadding: EdgeInsets.all(8.0),
              ),
            );
          },
        ),
      ),
    );
  }
}
