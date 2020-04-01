import 'package:currencyconverter/currency_converter_screen_folder/currency_converter_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:currencyconverter/loading_data_screen_folder/loading_data_screen.dart';
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
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.of(context),
      title: 'Currency Converter',
       home: LoadingDataScreen(),
       //CurrencyConverterMainScreen(),
    );
  }
}
