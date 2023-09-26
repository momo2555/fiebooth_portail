import 'package:fiebooth_portail/components/action_button.dart';
import 'package:fiebooth_portail/main.dart';
import 'package:flutter/material.dart';


class ButtonInfo {
  final String title;
  final dynamic Function() action;
  ButtonInfo({required this.title, required this.action});
}

showSimpleDialog(
    ButtonInfo leftButton, ButtonInfo rightButton, Widget content,
    [Widget title = const Placeholder()]) {
  showDialog(
    context: globalNavigatorKey.currentContext!,
    builder: (context) {
      return AlertDialog(
        titlePadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        title: Container(
          height: 65,
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          child: Center(child: title,)
        ),
        content: 
        Container(
          child: content,
        ),
        actions: [
          ActionButton.squaredDark(leftButton.title, leftButton.action),
          ActionButton.squaredLight(rightButton.title, rightButton.action),
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
