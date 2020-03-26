import 'package:flutter/material.dart';

class CurrencyIconButton extends StatelessWidget {
  final Function onTap;
  final String currencyShortName;

  CurrencyIconButton({@required this.onTap, @required this.currencyShortName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Image.asset(
          'assets/images/$currencyShortName.png',
          height: 35,
        ),
      ),
    );
  }
}
