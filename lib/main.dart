import 'package:currencyconverter/loading_screen_folder/loading_screen.dart';
import 'package:flutter/material.dart';
import 'themes_data/my_themes.dart';
import 'themes_data/custom_theme.dart';

//Currency converter learning project

void main() {
  runApp(
    CustomTheme(
      initialThemeKey: MyThemeKeys.LIGHT,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.of(context),
      title: 'Currency Converter',
       home: LoadingScreen(),
    );
  }
}
