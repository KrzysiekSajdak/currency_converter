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
  bool selectorVisibleFirstCurrency = false;
  bool selectorVisibleSecondCurrency = false;
  var testMap = {};
  String firstSelectedCurrency;
  String secondSelectedCurrency;

  double convertedCurrency;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _allData = _allCurrency.getData(coinURL);
    test();

    super.initState();
  }

  List currencyKeyList = [];

  void test() async {
    try {
      var data = await AllCurrency().getData(coinURL);
      testMap = data.allCurrency;
      for (var item in testMap.keys) {
        currencyKeyList.add(item.toString());
      }
    } catch (e) {
      print(e);
    }
  }

  Widget _appBody() {
    return SafeArea(
      child: Container(
        child: Center(
          child: FutureBuilder(
            future: _allData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CurrencyIconButton(
                        onTap: () {
                          setState(() {
                            selectorVisibleFirstCurrency = true;
                          });
                        },
                        currencyShortName: 'EUR',
                      ),
                      Text(
                        '1 EUR = ${snapshot.data.allCurrency['PLN'].toStringAsFixed(2)} PLN',
                        style: TextStyle(fontSize: 20),
                      ),
                      CurrencyIconButton(
                        onTap: () {
                          setState(() {
                            selectorVisibleSecondCurrency = true;
                          });
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

  Widget iOSPicker() {
    String pickerLabel() {
      String output;
      if (selectorVisibleFirstCurrency) {
        output = "first currency";
      } else if (selectorVisibleSecondCurrency) {
        output = "second currency";
      }
      return output.toUpperCase();
    }

    return Column(
      children: <Widget>[
        Expanded(
            flex: 1,
            child: Container(
                alignment: Alignment.center,
                color: Colors.black54,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(pickerLabel(),
                          style: TextStyle(color: Colors.grey.shade300)),
                    ),
                    IconButton(
                      icon: Icon(Icons.clear),
                      color: Colors.grey.shade300,
                      onPressed: () {
                        setState(() {
                          if (selectorVisibleSecondCurrency) {
                            selectorVisibleSecondCurrency = false;
                          } else if (selectorVisibleFirstCurrency) {
                            selectorVisibleFirstCurrency = false;
                          }
                        });
                      },
                    ),
                  ],
                ))),
        Expanded(
          flex: 4,
          child: CupertinoPicker.builder(
              backgroundColor: Colors.black38,
              childCount: currencyKeyList.length,
              squeeze: 1.2,
              itemExtent: 26.0,
              onSelectedItemChanged: (value) {
                print(value);
                setState(() {
                  if (selectorVisibleFirstCurrency) {
                    firstSelectedCurrency = currencyKeyList[value];
                  } else if (selectorVisibleSecondCurrency) {
                    secondSelectedCurrency = currencyKeyList[value];
                  }
                });

                if (firstSelectedCurrency != null &&
                    secondSelectedCurrency != null) {
                  convertedCurrency = (testMap[firstSelectedCurrency] /
                      testMap[secondSelectedCurrency]);
                }
              },
              itemBuilder: (BuildContext context, int index) {
                return Text(
                  currencyKeyList[index],
                  style: TextStyle(color: Colors.white, fontSize: 18),
                );
              }),
        ),
      ],
    );
  }

  IconButton addCurrencyButton(Function onPressed) {
    return IconButton(
      icon: Icon(Icons.add_circle_outline),
      color: kAddIconsColor,
      iconSize: kIconsSize,
      onPressed: onPressed,
    );
  }

  Widget firstFlagAndCurrencyShortName(String selectedCurrency) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset('assets/images/$selectedCurrency.png', width: 40,),
        ),
        Text('1 $selectedCurrency', style: kCurrencyValueTextStyle,),
      ],
    );
  }

  Widget secondFlagAndCurrencyShortName(String selectedCurrency, double convertedCurrency) {
    return Row(
      children: <Widget>[
        Text('1 $selectedCurrency', style: kCurrencyValueTextStyle,),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset('assets/images/$selectedCurrency.png', width: 40,),
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
          //Expanded(flex: 6, child: _appBody()),

          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                firstSelectedCurrency != null
                    ? firstFlagAndCurrencyShortName(firstSelectedCurrency)
                    : addCurrencyButton(() {
                      setState(() {
                        selectorVisibleFirstCurrency = true;
                        iOSPicker();
                      });
                }),
                (firstSelectedCurrency == null ||
                        secondSelectedCurrency == null)
                    ? Text(
                        ' add value ',
                        style: kFontsTextStyle,
                      )
                    : Text(' = ', style: kCurrencyValueTextStyle,),
                secondSelectedCurrency != null
                    ? secondFlagAndCurrencyShortName(secondSelectedCurrency, convertedCurrency)
                    : addCurrencyButton(() {
                      setState(() {
                        selectorVisibleSecondCurrency = true;
                        iOSPicker();
                      });
                }),
              ],
            ),
          ),
          Expanded(
              flex: 2,
              child: (selectorVisibleFirstCurrency ||
                      selectorVisibleSecondCurrency)
                  ? iOSPicker()
                  : Container()),
        ],
      ),
    );
  }
}
