class ConfigModel {
  String? userText;
  bool? useKeyboard;
  String? wifiSsid;
  String? wifiPassword;
  int? contrast;
  int? brightness;
  int? defaultBrightness;
  int? defaultContrast;
  ConfigModel(
      {this.userText,
      this.useKeyboard,
      this.wifiPassword,
      this.wifiSsid,
      this.contrast,
      this.brightness,
      this.defaultBrightness,
      this.defaultContrast});
  ConfigModel.empty();
  ConfigModel.copy(ConfigModel config) {
    userText = config.userText;
    useKeyboard = config.useKeyboard;
    wifiPassword = config.wifiPassword;
    wifiSsid = config.wifiSsid;
    contrast = config.contrast;
    brightness = config.brightness;
    defaultBrightness = config.defaultBrightness;
    defaultContrast = config.defaultContrast;
  }
}


