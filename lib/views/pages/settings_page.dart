import 'package:fiebooth_portail/components/action_button.dart';
import 'package:fiebooth_portail/components/simple_input.dart';
import 'package:fiebooth_portail/components/simple_text.dart';
import 'package:fiebooth_portail/controllers/fiebooth_controller.dart';
import 'package:fiebooth_portail/models/config_model.dart';
import 'package:fiebooth_portail/utils/global_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  FieboothController _fieboothController = FieboothController();
  ConfigModel _config = Globals.config;
  bool _disposed = false;
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _disposed = false;
    _fieboothController.getSettings().then((allSettings) {
      if (!_disposed) {
        setState(() {
          _config = allSettings;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _disposed = true;
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
                value: _config.userText ?? "",
                onChange: (value) {
                  _config.userText = value;
                },
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
                      value: _config.wifiSsid ?? "",
                      onChange: (value) {
                        _config.wifiSsid = value;
                      },
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
                      type: "password",
                      placeholder: "MDP",
                      value: _config.wifiPassword ?? "",
                      onChange: (value) {
                        _config.wifiPassword = value;
                      },
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
                value: ((_config.defaultContrast ?? 0) + 6) / 12,
                onChanged: (val) {
                  setState(() {
                    _config.defaultContrast = (val * 12 - 6).round();
                  });
                },
              ),
              SimpleText.label("luminosité imprimante :"),
              Slider(
                value: ((_config.defaultBrightness ?? 0) + 6) / 12,
                onChanged: (val) {
                  setState(() {
                    _config.defaultBrightness = (val * 12 - 6).round();
                  });
                },
              ),
              SimpleText.label("contraste :"),
              Slider(
                value: ((_config.contrast ?? 0) + 6) / 12,
                onChanged: (val) {
                  setState(() {
                    _config.contrast = (val * 12 - 6).round();
                  });
                },
              ),
              SimpleText.label("luminosité :"),
              Slider(
                value: ((_config.brightness ?? 0) + 6) / 12,
                onChanged: (val) {
                  setState(() {
                    _config.brightness = (val * 12 - 6).round();
                  });
                },
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
                  Switch(
                    value: _config.useKeyboard ?? true,
                    onChanged: (val) {
                      setState(() {
                        _config.useKeyboard = false;
                      });
                    },
                  ),
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
