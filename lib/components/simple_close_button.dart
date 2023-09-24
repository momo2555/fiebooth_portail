import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';


class SimpleCloseButton extends StatefulWidget {
  const SimpleCloseButton({Key? key}) : super(key: key);

  @override
  State<SimpleCloseButton> createState() => _SimpleCloseButtonState();
}

class _SimpleCloseButtonState extends State<SimpleCloseButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      child: CloseButton(
        color: Theme.of(context).primaryColorLight,
        onPressed: (){
           Navigator.pop(context);
        },

      ),
    );
    
  }
}