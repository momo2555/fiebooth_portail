import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SimpleText extends StatefulWidget {
  const SimpleText({
    Key? key,
    required this.text,
    this.size,
    this.thick,
    this.italic,
    this.color,
    this.center,
    this.cut,
    this.font,
  }) : super(key: key);
  final String text;
  final int? thick;
  final bool? italic;
  final double? size;
  final int? color;
  final bool? center;
  final bool? cut;
  final String? font;

  factory SimpleText.BigTitle(String text, [color = 0]) {
    return SimpleText(
      text: text,
      color: color,
      font: "Smoothie Shoppe",
      size: 50,
    );
  }
  factory SimpleText.menuTitle(String text, [color = 0]) {
    return SimpleText(
      text: text,
      color: color,
      font: "Smoothie Shoppe",
      size: 10,
    );
  }
  factory SimpleText.bigText(String text, [color = 0]) {
    return SimpleText(
      text: text,
      color: color,
      font: "Reem Kufi Fun",
      size: 32,

    );
  }
  factory SimpleText.titleText(String text) {
    return SimpleText(
      size: 25,
      thick: 5,
      text: text,
      color: 3,
      font: "Reem Kufi Fun",
    );
  }
  factory SimpleText.label(String text) {
    return SimpleText(
      text: text,
      color: 4,
      size: 16,
      thick: 5,
      font: "Reem Kufi Fun",
    );
  }
  factory SimpleText.labelTitle(String text) {
    return SimpleText(
      text: text,
      color: 3,
      thick: 5,
      size: 25,
      font: "Reem Kufi Fun",
    );
  }
  factory SimpleText.date(String text) {
    return SimpleText(
      text: text,
    );
  }
  factory SimpleText.msgDark(String text) {
    return SimpleText(
      text: text,
    );
  }
  factory SimpleText.msgLight(String text) {
    return SimpleText(
      text: text,
    );
  }
  factory SimpleText.simple(String text) {
    return SimpleText(
      color: 2,
      text: text,
      center: false,
    );
  }
  factory SimpleText.darkTitle(String text) {
    return SimpleText(
      color: 2,
      text: text,
      center: false,
      size: 20,
      thick: 6,
    );
  }
  @override
  State<SimpleText> createState() => _SimpleTextState();
}

class _SimpleTextState extends State<SimpleText> {
  Color? _color;
  FontWeight _thick = FontWeight.normal;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<FontWeight> weightList = [
      FontWeight.normal,
      FontWeight.w100,
      FontWeight.w200,
      FontWeight.w300,
      FontWeight.w400,
      FontWeight.w500,
      FontWeight.w600,
      FontWeight.w700,
      FontWeight.w800,
      FontWeight.w900,
    ];
    _thick = weightList[widget.thick ?? 0];
    _color = Theme.of(context).primaryColorLight;
    List<Color> colors = [
      Theme.of(context).primaryColorLight,
      Theme.of(context).colorScheme.onSecondary,
      Theme.of(context).colorScheme.onTertiary,
      Theme.of(context).colorScheme.tertiary,
      Theme.of(context).colorScheme.onSurface,
      Theme.of(context).colorScheme.background,
      Theme.of(context).colorScheme.error
    ];
    _color = colors[widget.color ?? 0];
    return Text(widget.text,
        overflow:
            widget.cut ?? false ? TextOverflow.ellipsis : TextOverflow.visible,
        style: TextStyle(
          color: _color ?? Theme.of(context).primaryColorLight,
          fontWeight: _thick,
          fontStyle:
              widget.italic ?? false ? FontStyle.italic : FontStyle.normal,
          fontSize: widget.size ?? 14,
          fontFamily: widget.font,
        ),
        textAlign: widget.center ?? true ? TextAlign.center : TextAlign.left);
  }
}
