import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:currencyconverter/all_currency.dart';
import 'package:currencyconverter/const_data.dart';
import 'package:currencyconverter/app_bar.dart';
import 'package:flutter/services.dart';
import 'currency_icon_button.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future<AllCurrency> _allData;
  AllCurrency _allCurrency = AllCurrency();
  bool selectorVisible = false;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _allData = _allCurrency.getData(coinURL);
    super.initState();
  }

  Widget _appBody() {
    return SafeArea(
      child: Container(
        child: Center(
          child: FutureBuilder(
            future: _allData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data.allCurrency['PLN']);
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CurrencyIconButton(
                        onTap: () {
                          setState(() {
                            selectorVisible = true;
                          });
                          print('first - ok');
                        },
                        currencyShortName: 'EUR',
                      ),
                      Text(
                        '1 EUR = ${snapshot.data.allCurrency['PLN'].toStringAsFixed(2)} PLN',
                        style: TextStyle(fontSize: 20),
                      ),
                      CurrencyIconButton(
                        onTap: () {
                          print('second - ok');
                        },
                        currencyShortName: 'PLN',
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                print('error');
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  List a = ["a", "b", "c"];

  Widget iOSPicker() {
    return Column(
      children: <Widget>[
        Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
                color: Colors.black54, child: Text('first currency'))),
        Expanded(
          flex: 4,
          child: CupertinoPicker.builder(
              backgroundColor: Colors.black38,
              childCount: a.length,
              squeeze: 1.2,
              itemExtent: 26.0,
              onSelectedItemChanged: (value) {
                print(value);
              },
              itemBuilder: (BuildContext context, int index) {
                return Text(
                  a[index],
                  style: TextStyle(color: Colors.white, fontSize: 18),
                );
              }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(screenTitle: 'Currency Converter'),
      body: Column(
        children: <Widget>[
          Expanded(flex: 6, child: _appBody()),
          Expanded(flex: 2, child: selectorVisible ? iOSPicker() : Container()),
        ],
      ),
    );
  }
}
