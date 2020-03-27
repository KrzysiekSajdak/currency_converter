import 'package:flutter/material.dart';
import 'currency_icon_button.dart';
import 'package:currencyconverter/const_files/const_data.dart';

class FlagAndCurrencyName extends StatelessWidget {
  final selectedCurrency;
  final onTap;
  final textValue;
  final secondFlag;

  FlagAndCurrencyName(
      {@required this.selectedCurrency,
      @required this.onTap,
      this.textValue,
      @required this.secondFlag,});

  Widget _flagAndCurrencyCard() {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 3,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  width: 70,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.asset(
                      'assets/images/$selectedCurrency.png',
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(textValue, style: kCurrencyValueTextStyle,),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return secondFlag
        ? _flagAndCurrencyCard()
        : _flagAndCurrencyCard();
  }
}
