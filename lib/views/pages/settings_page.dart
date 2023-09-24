import 'package:fiebooth_portail/components/simple_input.dart';
import 'package:fiebooth_portail/components/simple_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Widget _configTitle(String title) {
    return Row(
      children: [
        SimpleText.labelTitle(title)
      ],
    );
  }
  Widget _configBloc(List<Widget> children) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.all(12.0),
      child: Column(children: children),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
         
          _configBloc([
            _configTitle("Texte personnalisé"),
            SimpleInput(
              style: "filled",
              placeholder: "Texte personnalisé",
            )
          ]),


          /*_configBloc([
            _configTitle("Paramètres réseau Wifi"),
            Row(
              children: [
                SimpleText.date("SSID"),
                SimpleInput(
                  style: "filled",
                  placeholder: "SSID",
                ),
              ],
            )
          ]),*/
    
        ],
      ),
    );
  }
}