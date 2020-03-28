import 'package:currencyconverter/const_files/const_data.dart';
import 'package:flutter/material.dart';

enum MyThemeKeys {LIGHT, DARK, DARKER}

class MyThemes {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    accentColor: kMainPurple,
    primaryColor: kMainPurple,
    primaryColorLight: kMiddlePurple,
      buttonTheme: ButtonThemeData(
          buttonColor: kMiddlePurple,
          splashColor: kPressedButton,
        textTheme: ButtonTextTheme.normal,
  ),

  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColorLight: kMiddlePurple,
    buttonTheme: ButtonThemeData(
      buttonColor: kMiddlePurple,
      splashColor: kPressedButton
    )
  );

  static final ThemeData darkerTheme = ThemeData.dark();

  static ThemeData getThemeFromKey(MyThemeKeys themeKey) {
    switch (themeKey) {
      case MyThemeKeys.LIGHT:
        return lightTheme;
      case MyThemeKeys.DARK:
        return darkTheme;
      case MyThemeKeys.DARKER:
        return darkerTheme;
      default:
        return lightTheme;
    }
  }
}
