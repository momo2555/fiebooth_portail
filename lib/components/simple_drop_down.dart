import 'package:fiebooth_portail/components/simple_text.dart';
import 'package:flutter/material.dart';

class SimpleDropDown extends StatefulWidget {
  const SimpleDropDown({
    Key? key,
    required this.items,
    this.initialValue,
    this.focusNode,
    this.nextNode,
    this.onChange,
    this.dropDownKey,
  }) : super(key: key);
  final GlobalKey? dropDownKey;
  final List<String> items;
  final String? initialValue;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final Function(String value)? onChange;
  @override
  State<SimpleDropDown> createState() => _SimpleDropDownState();
}

class _SimpleDropDownState extends State<SimpleDropDown> {
  String _value = '';
  get getValue {
    return _value;
  }

  InputDecoration _lightDecorationFilled() {
    return InputDecoration(
      /*prefixIcon: widget.icon,
      hintText: widget.placeholder ?? '',
      prefixText: widget.type == "phone" ? "+33" : null,*/
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
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),

      fillColor: Color(0xFFEBEBEB),
      filled: true,
      contentPadding: const EdgeInsets.all(17),

      focusColor: Theme.of(context).colorScheme.secondary,
     
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _value = widget.initialValue ?? (widget.items.isNotEmpty? widget.items[0] : "");
    return DropdownButtonFormField(
      key: widget.dropDownKey,
      items: widget.items
          .map(
            (e) => DropdownMenuItem<String>(
              value: e,
              child: SimpleText.darklabel(e)
            ),
          )
          .toList(),
      onChanged: (val) {
        widget.onChange!(val.toString());
      },
      isExpanded: true,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      style: TextStyle(color: Theme.of(context).primaryColorDark),
    
      decoration: _lightDecorationFilled(),
      focusNode: widget.focusNode,
      
      
    );
  }
}
