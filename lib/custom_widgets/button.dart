import 'package:flutter/material.dart';
import 'package:bossword/utilities/constants.dart';

class Button extends StatelessWidget {
  Button({@required this.text, @required this.onPressed});

  final text;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(46.0),
      child: GestureDetector(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: kInputBoxStyle,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            shape: BoxShape.rectangle,
            color: kRedColor,
          ),
          width: double.infinity,
        ),
        onTap: onPressed,
      ),
    );
  }
}

//Padding(
//padding: EdgeInsets.all(8.0),
//child: RaisedButton(
//child: Padding(
//padding: const EdgeInsets.all(18.0),
//child: Text(
//text,
//style: kInputBoxStyle.copyWith(
//color: kRedColor,
//),
//),
//),
//onPressed: onPressed,
//color: kButtonColor,
//shape: RoundedRectangleBorder(
//borderRadius: BorderRadius.circular(6.0),
//),
//),
//)
