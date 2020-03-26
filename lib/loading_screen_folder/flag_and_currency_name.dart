import 'package:flutter/material.dart';
import 'currency_icon_button.dart';
import 'package:currencyconverter/const_files/const_data.dart';

class FlagAndCurrencyName extends StatelessWidget {

  final selectedCurrency;
  final onTap;
  final textValue;
  final secondFlag;

  FlagAndCurrencyName(
      {@required this.selectedCurrency, @required this.onTap, this.textValue, @required this.secondFlag});

  @override
  Widget build(BuildContext context) {
    return secondFlag ? Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[

          Text(
            textValue,
            style: kCurrencyValueTextStyle,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CurrencyIconButton(
              currencyShortName: selectedCurrency,
              onTap: onTap,
            ),
          ),
        ],
      ),
    ) : Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CurrencyIconButton(
              currencyShortName: selectedCurrency,
              onTap: onTap,
            ),
          ),
          Text(
            textValue,
            style: kCurrencyValueTextStyle,
          ),
        ],
      ),
    );
  }
}
