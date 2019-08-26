import 'package:flutter/material.dart';
import 'package:bossword/utilities/constants.dart';

class InputBox extends StatelessWidget {

  InputBox({@required this.text, this.hintText, this.obscureText, @required this.icon});

  final text;
  final hintText;
  final obscureText;
  final icon;
  var input;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: text,
          labelStyle: kInputBoxStyle,
          hintText: hintText,
          hintStyle: kInputBoxStyle.copyWith(fontSize: 16.0),
          contentPadding: EdgeInsets.all(16.0),
          icon: icon,
          filled: true,
          fillColor: kInputBoxColor,
          alignLabelWithHint: true,
        ),
        style: kInputBoxInputTextStyle,
        obscureText: obscureText??false,
        onChanged: (val) {
          input = val;
        },
        cursorColor: kRedColor.withOpacity(0.7),
        cursorWidth: 3.5,
        cursorRadius: Radius.circular(6.0),
      ),
    );
  }
}
