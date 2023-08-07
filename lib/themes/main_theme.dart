import 'package:flutter/material.dart';

const PrimaryColor = Color(0xFFFADE52);
const PrimaryColorLight = Color.fromARGB(255, 255, 255, 255);
const PrimaryColorDark = Color(0xFF8F6600);

const SecondaryColor = Color(0xFF92D6D9);
const SecondaryColorLight = Color(0xFFe5ffff);
const SecondaryColorDark =  Color(0xFF1E5557);

const errorColor = Color(0xFFFC7759);
const highlightColor = Color(0xFFFC7759);

const darkText = Color(0xFF3B3B3B);
const lightText = Color(0xFF969696);
const onSurface = Color(0xFFEBEBEB);
const surface =  Color(0xFFF5F5F5);

const Background = Colors.white;

class mainTheme {
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
