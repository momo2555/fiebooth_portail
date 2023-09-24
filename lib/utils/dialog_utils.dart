import 'package:fiebooth_portail/components/action_button.dart';
import 'package:flutter/material.dart';


class ButtonInfo {
  final String title;
  final dynamic Function() action;
  ButtonInfo({required this.title, required this.action});
}

showSimpleDialog(
    context, ButtonInfo leftButton, ButtonInfo rightButton, Widget content,
    [Widget title = const Placeholder()]) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: title,
        content: 
        Container(
          child: content,
        ),
        actions: [
          /*ActionButton.simpleYellow(leftButton.title, leftButton.action),
          ActionButton.simpleBlue(rightButton.title, rightButton.action),*/
        ],
      );
    },
  );
}

Widget logOutCaption(context) {
  return Align(
    alignment: Alignment.center,
    child: Container(
    width: 90,
    height: 90,
    color: Theme.of(context).primaryColor,
      child: Center(
        child: Icon(Icons.power_settings_new, color: Theme.of(context).colorScheme.background,),
      ),
  ),
  );
}
