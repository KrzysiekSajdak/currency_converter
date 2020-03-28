import 'package:currencyconverter/themes_data/my_themes.dart';
import 'package:flutter/material.dart';
import 'package:currencyconverter/const_files/const_data.dart';
import 'package:currencyconverter/loading_screen_folder/drawer.dart';

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

  Border _border() {
    var out;
    if (currentTheme != MyThemeKeys.DARK) {
      out = Border.all(color: Colors.black, width: 1);
    }
    return out;
  }

  String _currencyLongName(shortName) {
    String out;

    switch(shortName) {
      case 'CAD':
        out = 'Canadian Dollar';
        break;
      case 'HKD':
        out = 'Hong Kong Dollar';
        break;
      case 'ISK':
        out = 'Icelandic Krona';
        break;
      case 'PHP':
        out = 'Philippine Peso';
        break;
      case 'DKK':
        out = 'Danish Krone ';
        break;
      case 'HUF':
        out = 'Hungarian Forint';
        break;
      case 'CZK':
        out = 'Czech Koruna';
        break;
      case 'AUD':
        out = 'Australian Dollar';
        break;
      case 'RON':
        out = 'Romanian Leu';
        break;
      case 'SEK':
        out = 'Swedish Krona';
        break;
      case 'IDR':
        out = 'Indonesian Rupiah';
        break;
      case 'INR':
        out = 'Indian Rupee';
        break;
      case 'BRL':
        out = 'Brazilian Real';
        break;
      case 'RUB':
        out = 'Russian Ruble';
        break;
      case 'HRK':
        out = 'Croatian Kuna';
        break;
      case 'JPY':
        out = ' Japanese Yen';
        break;
      case 'THB':
        out = ' Thai Baht';
        break;
      case 'CHF':
        out = 'Swiss Franc';
        break;
      case 'SGD':
        out = 'Singapore Dollar';
        break;
      case 'BGN':
        out = 'Bulgarian Lev';
        break;
      case 'TRY':
        out = 'Turkish Lira';
        break;
      case 'CNY':
        out = 'Chinese Yuan Renminbi';
        break;
      case 'NOK':
        out = 'Norwegian Krone';
        break;
      case 'NZD':
        out = 'New Zealand Dollar';
        break;
      case 'ZAR':
        out = 'South African Rand';
        break;
      case 'USD':
        out = 'US Dollar';
        break;
      case 'MXN':
        out = 'Mexican Peso';
        break;
      case 'ILS':
        out = 'Israeli Shekel';
        break;
      case 'GBP':
        out = 'British Pound';
        break;
      case 'KRW':
        out = 'South Korean Won';
        break;
      case 'MYR':
        out = 'Malaysian Ringgit';
        break;
      case 'EUR':
        out = 'Euro';
        break;
      case 'PLN' :
        out = 'Polish złoty';
        break;
      default :
        out = 'none';
    }
    return out;
  }

  Widget _flagAndCurrencyCard() {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: _border(),
                  ),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(textValue, style: kCurrencyValueTextStyle,),
                  Text(_currencyLongName(selectedCurrency), style: TextStyle(fontStyle: FontStyle.italic),),
                ],
              ),
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
