import 'package:flutter/material.dart';

const PrimaryColor = Color(0xFF778792);
const PrimaryColorLight = Color.fromARGB(255, 255, 255, 255);
const PrimaryColorDark = Color(0xFF4D5356);

const SecondaryColor = Color(0xFFDEAD6E);
const SecondaryColorLight = Color.fromARGB(255, 255, 255, 255);
const SecondaryColorDark = Color(0xFF64553F);

const errorColor = Color(0xFFFC7759);
const highlightColor = Color(0xFFFC7759);

const darkText = Color(0xFF3B3B3B);
const lightText = Color(0xFFFFF4E5);
const onSurface = Color(0xFFCFCFCF);
const surface =  Color(0xFFA5ACB1);

const Background = Color(0xFF8D959A);

class MainTheme {
  static final ThemeData defaultTheme = _buildMyTheme();

  static ThemeData _buildMyTheme() {
    final ThemeData base = ThemeData(fontFamily: 'Poppins');

    return base.copyWith(
      
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: PrimaryColor,
        onPrimary: PrimaryColorDark,
        secondary: SecondaryColor,
        onSecondary: SecondaryColorDark,
        error: errorColor,
        onError: errorColor,
        background: Background,
        onBackground: PrimaryColorLight,
        surface: surface,
        onSurface: onSurface,
        tertiary: lightText,
        onTertiary: darkText,

        
      ),
      primaryColor: PrimaryColor,
      primaryColorDark: PrimaryColorDark,
      primaryColorLight: PrimaryColorLight,
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: SecondaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: Background,
      ),
      floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
        backgroundColor: PrimaryColor,
        
      ),
      scaffoldBackgroundColor: Background,
      cardColor: Background,
      bottomAppBarTheme: base.bottomAppBarTheme.copyWith(
        elevation: 0,
      ),
      textTheme: base.textTheme.copyWith(
        bodyLarge: TextStyle(),
        bodyMedium: TextStyle(),
        bodySmall: TextStyle(),
        displayLarge: TextStyle(),
        displayMedium: TextStyle(),
        displaySmall: TextStyle(),
        headlineLarge: TextStyle(
          fontFamily: "Irish Grover"
        ), //title of the app
        headlineMedium: TextStyle(
          fontFamily: "Irish Grover"
        ), 
        headlineSmall: TextStyle(),
        labelLarge: TextStyle(),
        labelMedium: TextStyle(),
        labelSmall: TextStyle(),
        titleLarge: TextStyle(),
        titleMedium: TextStyle(),
        titleSmall: TextStyle(),
        
      )
      /*textTheme: base.textTheme.copyWith(
          titleLarge: base.textTheme.titleLarge?.copyWith(color: TextColor),
          bodyText1: base.textTheme.bodyText1?.copyWith(color: TextColor),
          bodyText2: base.textTheme.bodyText2?.copyWith(color: TextColor)
      ),*/
    );
  }
}
