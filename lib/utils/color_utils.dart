import 'package:fiebooth_portail/main.dart';
import 'package:flutter/material.dart';


class ColorUtils {
  static var context = globalNavigatorKey.currentContext;
  static var background = Theme.of(ColorUtils.context!).colorScheme.background;
  static var primary = Theme.of(ColorUtils.context!).colorScheme.primary;
  static var primaryDark = Theme.of(ColorUtils.context!).colorScheme.onPrimary;
  static var secondary = Theme.of(ColorUtils.context!).colorScheme.secondary;
  static var secondaryDark = Theme.of(ColorUtils.context!).colorScheme.onSecondary;
  static var textDark = Theme.of(ColorUtils.context!).colorScheme.onTertiary;
  static var textLight = Theme.of(ColorUtils.context!).colorScheme.tertiary;
}