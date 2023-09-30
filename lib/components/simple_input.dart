import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinbox/material.dart';

class SimpleInput extends StatefulWidget {
  const SimpleInput({
    Key? key,
    this.placeholder,
    this.type,
    this.icon,
    this.textInputAction,
    this.focusNode,
    this.nextNode,
    this.previousNode,
    this.onChange,
    this.validator,
    this.value = "",
    this.minLines,
    this.maxLines,
    this.inputFormatters,
    this.controller,
    this.style,
    this.label,
  }) : super(key: key);
  final String? label;
  final String? placeholder;
  final String? type;
  final Icon? icon;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final FocusNode? previousNode;
  final Function(dynamic value)? validator;
  final Function(String value)? onChange;
  final String value;
  final int? minLines;
  final int? maxLines;
  final TextEditingController? controller;
  final TextInputFormatter? inputFormatters;
  final String? style;
  @override
  State<SimpleInput> createState() => _SimpleInputState();
}

class _SimpleInputState extends State<SimpleInput> {
  String value = '';
  bool _obscureText = true;
  get getValue {
    return value;
  }

  InputDecoration _inputdecoration() {
    return InputDecoration(
      prefixIcon: widget.type == "phone"
          ? Padding(
              padding: const EdgeInsets.only(top: 22),
              child: Text(
                "+33",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            )
          : widget.icon,
      hintText: widget.placeholder ?? '',
      labelText: widget.label != null ? widget.label?.toUpperCase() : null,
      floatingLabelBehavior: FloatingLabelBehavior.always,

      floatingLabelStyle: TextStyle(
        color: Theme.of(context).primaryColorLight,
      ),

      prefixStyle: TextStyle(
          color: Colors.green, fontWeight: FontWeight.bold, fontSize: 17),
      hintStyle: TextStyle(
          color: Theme.of(context).primaryColorLight,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w100),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
        color: Theme.of(context).primaryColorLight,
        width: 0.3,
      )),
      border: UnderlineInputBorder(
          borderSide: BorderSide(
        color: Theme.of(context).primaryColorLight,
        width: 0.3,
      )),
      errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
        color: Colors.red,
        width: 0.3,
      )),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
        color: Theme.of(context).primaryColor,
        width: 0.3,
      )),
      //fillColor: Theme.of(context).backgroundColor,
      //filled: true,
      contentPadding: const EdgeInsets.all(10),

      suffixIcon: widget.type == 'password'
          ? InkWell(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: _obscureText
                  ? Icon(
                      Icons.visibility,
                      color: Theme.of(context).primaryColor,
                    )
                  : Icon(
                      Icons.visibility_off,
                      color: Theme.of(context).primaryColor,
                    ),
            )
          : null,
      focusColor: Theme.of(context).primaryColorLight,
      suffixIconColor: Theme.of(context).accentColor,

      //labelText: widget.placeholder ?? '',
    );
  }

  InputDecoration _inputdecorationFilled() {
    return InputDecoration(
      prefixIcon: widget.icon,
      hintText: widget.placeholder ?? '',
      prefixText: widget.type == "phone" ? "+33" :null,
      prefixStyle: TextStyle(
          color: Colors.green, fontWeight: FontWeight.bold, fontSize: 17),
      hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.surface,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w100),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.transparent)
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      fillColor: Color(0xFFEBEBEB),
      filled: true,
      contentPadding: const EdgeInsets.all(17),
      suffixIcon: widget.type == 'password'
          ? InkWell(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: _obscureText
                  ? Icon(
                      Icons.visibility,
                      color: Theme.of(context).colorScheme.secondary,
                    )
                  : Icon(
                      Icons.visibility_off,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
            )
          : null,
      focusColor: Theme.of(context).colorScheme.secondary,
      suffixIconColor: Theme.of(context).accentColor,

      //labelText: widget.placeholder ?? '',
    );
  }

  InputDecoration _lightDecorationFilled() {
    return InputDecoration(
      prefixIcon: widget.icon,
      hintText: widget.placeholder ?? '',
      prefixText: widget.type == "phone" ? "+33" :null,
      prefixStyle: TextStyle(
          color: Colors.green, fontWeight: FontWeight.bold, fontSize: 17),
      hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.surface,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w100),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.transparent)
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      fillColor: Theme.of(context).colorScheme.onBackground.withAlpha(199),
      filled: true,
      contentPadding: const EdgeInsets.all(17),
      suffixIcon: widget.type == 'password'
          ? InkWell(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: _obscureText
                  ? Icon(
                      Icons.visibility,
                      color: Theme.of(context).colorScheme.secondary,
                    )
                  : Icon(
                      Icons.visibility_off,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
            )
          : null,
      focusColor: Theme.of(context).colorScheme.secondary,
      suffixIconColor: Theme.of(context).accentColor,

      //labelText: widget.placeholder ?? '',
    );
  }

  InputDecoration _decoration() {
    if ((widget.style ?? "default") == "filled") {
      return _inputdecorationFilled();
    }
    if ((widget.style ?? "default") == "light") {
      return _lightDecorationFilled();
    }
    return _inputdecoration();
  }

  TextStyle _textStyle() {
    return  TextStyle(color: Theme.of(context).primaryColorDark);
  }


  //TODO implement password type
  Widget _simpleInput() {
    return TextFormField(
      //textAlign: TextAlign.center,
      controller: widget.controller,
      style: _textStyle(),
      decoration: _decoration(),
      onChanged: (val) {
        value = val;
        widget.onChange != null ? widget.onChange!(val) : () {};
      },
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      onSaved: (value) {
        widget.nextNode?.requestFocus();
      },
      validator: (value) =>
          (widget.validator != null ? widget.validator!(value) : null),
      initialValue: widget.value,
    );
  }

  Widget _phoneInput() {
    return TextFormField(
      keyboardType: TextInputType.number,
      //TextAlign.center,
      controller: widget.controller,
      style: TextStyle(color: Theme.of(context).primaryColorLight),
      decoration: _decoration(),
      onChanged: (val) {
        value = val;
        widget.onChange != null ? widget.onChange!(val) : () {};
      },
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      onSaved: (value) {
        widget.nextNode?.requestFocus();
      },
      validator: (value) =>
          (widget.validator != null ? widget.validator!(value) : null),
      initialValue: widget.value,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        // Fit the validating format.
        _UsNumberTextInputFormatter(),
      ],
    );
  }

  Widget _multilineInput() {
    return TextFormField(
      controller: widget.controller,
      style: TextStyle(color: (widget.style??"default")=="light"?Theme.of(context).primaryColorDark:Theme.of(context).primaryColorLight),
      decoration: _decoration(),
      maxLines: widget.maxLines ?? 5,
      minLines: widget.minLines ?? 3,
      keyboardType: TextInputType.multiline,
      onChanged: (val) {
        value = val;
        widget.onChange != null ? widget.onChange!(val) : () {};
      },
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      onSaved: (value) {
        widget.nextNode?.requestFocus();
      },
      validator: (value) =>
          (widget.validator != null ? widget.validator!(value) : null),
      initialValue: widget.value,
    );
  }

  Widget _numericInput() {
    return TextFormField(
      controller: widget.controller,
      //textAlign: TextAlign.center,
      style: TextStyle(color: (widget.style??"default")=="light"?Theme.of(context).primaryColorDark:Theme.of(context).primaryColorLight),
      decoration: _decoration(),
      keyboardType: TextInputType.number,
      onChanged: (val) {
        value = val;
        widget.onChange != null ? widget.onChange!(val) : () {};
      },
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      onSaved: (value) {
        widget.nextNode?.requestFocus();
      },
      validator: (value) =>
          (widget.validator != null ? widget.validator!(value) : null),
      initialValue: widget.value,
    );
  }
  Widget _spinboxInput () {
    return SpinBox(
      textStyle:  TextStyle(color: (widget.style??"default")=="light"?Theme.of(context).primaryColorDark:Theme.of(context).primaryColorLight),
      decoration: _decoration(),
      decimals: 2,
       //acceleration: 0.01,
      digits: 3,
      step: 0.01,
      spacing: 40,
      value: double.parse(widget.value),
      onChanged: (val) {
        value = val.toString();
        widget.onChange != null ? widget.onChange!(val.toString()) : () {};
      },
    );
  }
  Widget _passwordInput() {
    return TextFormField(
      //textAlign: TextAlign.center,
      controller: widget.controller,
      style: _textStyle(),
      decoration: _decoration(),
      onChanged: (val) {
        value = val;
        widget.onChange != null ? widget.onChange!(val) : () {};
      },
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      onSaved: (value) {
        widget.nextNode?.requestFocus();
      },
      validator: (value) =>
          (widget.validator != null ? widget.validator!(value) : null),
      obscureText: _obscureText,
      initialValue: widget.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == 'multiline') {
      return _multilineInput();
    } else if (widget.type == 'numeric') {
      return _numericInput();
    } else if (widget.type == "password") {
      return _passwordInput();
    } else if (widget.type == 'phone') {
      return _phoneInput();
    } else if (widget.type == 'spinbox') {
      return _spinboxInput();
    } else {
      return _simpleInput();
    }
  }
}

/// Format incoming numeric tt to fit the format of (###) ###-#### ##
class _UsNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String workValue = newValue.text;
    final newTextLength = workValue.length;
    var selectionIndex = newValue.selection.end;
    if (!workValue.startsWith('0') && newTextLength > 0) {
      workValue = '0' + workValue;
      selectionIndex++;
    }

    final newText = StringBuffer();

    var usedSubstringIndex = 0;

    if (newTextLength >= 1) {
      newText.write('(${workValue.substring(0, usedSubstringIndex = 1)})');
      if (newValue.selection.end >= 1) selectionIndex += 2;
    }
    if (newTextLength >= 3) {
      newText.write('${workValue.substring(1, usedSubstringIndex = 2)} ');
      if (newValue.selection.end >= 1) selectionIndex++;
    }
    if (newTextLength >= 5) {
      newText.write('${workValue.substring(2, usedSubstringIndex = 4)} ');
      if (newValue.selection.end >= 3) selectionIndex += 1;
    }
    if (newTextLength >= 7) {
      newText.write('${workValue.substring(4, usedSubstringIndex = 6)} ');
      if (newValue.selection.end >= 5) selectionIndex += 1;
    }
    if (newTextLength >= 9) {
      newText.write('${workValue.substring(6, usedSubstringIndex = 8)} ');
      if (newValue.selection.end >= 7) selectionIndex += 1;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex) {
      newText.write(workValue.substring(usedSubstringIndex));
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
