import 'package:bossword/screens/all_passwords.dart';
import 'package:bossword/screens/boss_login.dart';
import 'package:bossword/utilities/constants.dart';
import 'package:flutter/material.dart';

void main() => runApp(HomeScreen());

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        accentColor: kRedColor,
        textSelectionHandleColor: kRedColor,
        toggleableActiveColor: kRedColor,
        scaffoldBackgroundColor: Color(0xFF242528)
      ),
      title: 'BossWord',
      initialRoute: BossLogin.routeName,
      routes: {
        BossLogin.routeName: (context) => BossLogin(),
        AllPasswords.routeName: (context) => AllPasswords(),
      },
    );
  }
}
