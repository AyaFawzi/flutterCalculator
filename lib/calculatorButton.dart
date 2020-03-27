import 'package:flutter/material.dart';

MyButton(
    {String buttonText,
      Color buttonColor,
      double buttonPadding,
      Color textColor,
      onPress () }){
  return RaisedButton(
      onPressed: (){
        onPress();
      },
      child: Text(
        buttonText,
        style: TextStyle(
            color: textColor, fontSize: 25, fontWeight: FontWeight.bold),
      ),
      elevation: 30,
      focusColor: Colors.white70,
      splashColor: Colors.grey,
      color: buttonColor,
      shape: CircleBorder(side: BorderSide(color: Colors.white, width: .5)),
      padding: EdgeInsets.all(15));
}