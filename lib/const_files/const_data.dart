import 'package:flutter/material.dart';

const String coinURL = 'https://api.exchangeratesapi.io/latest';

//TextStyles
TextStyle kFontsTextStyle = TextStyle (fontSize: 20, fontStyle: FontStyle.italic, color: Colors.grey);
TextStyle kCurrencyValueTextStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);

//Items sizes
const double kIconsSize = 30;

//
double kDynamicItemsSize({ctx, value}) {
  var output;

  output = (MediaQuery.of(ctx).size.height / MediaQuery.of(ctx).size.width) * value;

  return output;
}

//Items colours
const Color kAddIconsColor = Colors.grey;
const Color kUnpressedButton = Colors.black54;
const Color kLightPurple = Color(0xFFE0CEFD);
const Color kMiddlePurple = Color(0xFFB490EA);
const Color kPressedButton = Color(0xFF722CDB);
const Color kMainPurple = Color(0xFF6205E5);

bool darkColor = true;
