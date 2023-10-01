import 'package:fiebooth_portail/components/action_button.dart';
import 'package:fiebooth_portail/components/simple_input.dart';
import 'package:fiebooth_portail/components/simple_text.dart';
import 'package:fiebooth_portail/controllers/fiebooth_controller.dart';
import 'package:fiebooth_portail/models/config_model.dart';
import 'package:fiebooth_portail/utils/dialog_utils.dart';
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
  bool _wait = false;
  bool _disposed = false;
  TextEditingController _wifiPasswordController = TextEditingController();
  TextEditingController _wifiSsidController = TextEditingController();
  TextEditingController _userTextController = TextEditingController();
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
  void _updateTextInputs() {
    _wifiPasswordController.text = _config.wifiPassword??"";
    _wifiSsidController.text = _config.wifiSsid??"";
    _userTextController.text = _config.userText??"";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateTextInputs();
    _disposed = false;
    _wait = true;
    _fieboothController.getSettings().then((allSettings) {
      if (!_disposed) {
        setState(() {
          _config = ConfigModel.copy(allSettings);
          _updateTextInputs();
          print("config : ${_config.wifiPassword}");
          Globals.config = ConfigModel.copy(allSettings);
          _wait = false;
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
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _configBloc([
                  _configTitle("Texte personnalisé"),
                  SimpleInput(
                    style: "filled",
                    placeholder: "Texte personnalisé",
                    //value: _config.userText ?? "",
                    controller: _userTextController,
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
                          //value: _config.wifiSsid ?? "",
                          controller: _wifiSsidController,
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
                          controller: _wifiPasswordController,
                          //value: _config.wifiPassword ?? "",
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
                            _config.useKeyboard = val;
                          });
                        },
                      ),
                    ],
                  )
                ]),
                SizedBox(
                  height: 15,
                ),
                ActionButton.action("Sauvegarder", () async {
                  _wait = true;
                  await _fieboothController.setSettings(Globals.config, _config);
                  Globals.config = ConfigModel.copy(_config);
                  _wait = false;
                  showSimpleDialog(null, ButtonInfo(title: "Okay", action: () {
                    Navigator.pop(context); 
                  }), SimpleText.label("Enregistrement des nouveaux paramètres effectué avec succès"),
                  SimpleText.titleText("Confirmation"));
                  
                }),
              ],
            ),
          ),
        ),
        _wait?
        Container(
          color: Theme.of(context).primaryColorDark.withAlpha(140),
          child: Center(child: CircularProgressIndicator()),
        ):const SizedBox(height: 0,width: 0,),
      ],
    );
  }
}
