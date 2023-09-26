import 'package:fiebooth_portail/components/action_button.dart';
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
      children: [SimpleText.labelTitle(title)],
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            _configBloc([
              _configTitle("Texte personnalisé"),
              SimpleInput(
                style: "filled",
                placeholder: "Texte personnalisé",
              )
            ]),
            SizedBox(
              height: 15,
            ),
            _configBloc([
              _configTitle("Paramètres réseau Wifi"),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SimpleText.label("SSID"),
                  ),
                  Flexible(
                    child: SimpleInput(
                      style: "filled",
                      placeholder: "SSID",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SimpleText.label("MDP"),
                  ),
                  Flexible(
                    child: SimpleInput(
                      style: "filled",
                      placeholder: "MDP",
                    ),
                  ),
                ],
              )
            ]),
            SizedBox(
              height: 15,
            ),
            _configBloc([
              _configTitle("Paramètres image"),
              SimpleText.label("contraste imprimante :"),
              Slider(
                value: 0.5,
                onChanged: (val) {},
                
              ),
              SimpleText.label("luminosité imprimante :"),
              Slider(
                value: 0.5,
                onChanged: (val) {},
                
              ),
              SimpleText.label("contraste :"),
              Slider(
                value: 0.5,
                onChanged: (val) {},
                
              ),
              SimpleText.label("luminosité :"),
              Slider(
                value: 0.5,
                onChanged: (val) {},
                
              ),
            ]),
            SizedBox(
              height: 15,
            ),
            _configBloc([
              _configTitle("Autres"),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SimpleText.label("Utiliser le clavier"),
                  ),
                  Switch(value: true, onChanged: (val) {},),
                ],
              )
            ]),
             SizedBox(
              height: 15,
            ),
            ActionButton.action("Sauvegarder", () => null)
          ],
        ),
      ),
    );
  }
}
