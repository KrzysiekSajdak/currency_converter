import 'package:currencyconverter/loading_screen_folder/loading_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData.dark(),
      home: LoadingScreen(),
      //PriceScreen(),
    );
  }
}

