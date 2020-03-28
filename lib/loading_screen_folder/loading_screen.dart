import 'package:currencyconverter/loading_screen_folder/drawer.dart';
import 'package:currencyconverter/loading_screen_folder/flag_and_currency_name.dart';
import 'package:currencyconverter/loading_screen_folder/ios_currency_picker.dart';
import 'package:currencyconverter/themes_data/my_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:currencyconverter/loading_screen_folder/all_currency.dart';
import 'package:currencyconverter/const_files/const_data.dart';
import 'package:currencyconverter/all_pages_widgets/app_bar.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool selectorVisibleFirstCurrency = false;
  bool selectorVisibleSecondCurrency = false;
  var loadedCurrencyData = {};
  String firstSelectedCurrency;
  String secondSelectedCurrency;
  bool secondFlag;
  String updateDateValue;
  double convertedCurrency = 0;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    fetchCurrencyData();

    _allData = allCurrency.getData(coinURL);
    super.initState();
  }

  List currencyKeyList = [];

  Future<AllCurrency> _allData;
  AllCurrency allCurrency = AllCurrency();

  void fetchCurrencyData() async {
    try {
      var data = await AllCurrency().getData(coinURL);
      loadedCurrencyData = data.allCurrency;
      loadedCurrencyData.addAll({"EUR": 1});
      updateDateValue = data.updateDate;
      for (var item in loadedCurrencyData.keys) {
        currencyKeyList.add(item.toString());
      }
    } catch (e) {
      print(e);
    }
  }

  IOSCurrencyPicker _iOSPicker() {
    return IOSCurrencyPicker(
      currencyKeyList: currencyKeyList,
      firstSelectedCurrency: firstSelectedCurrency,
      secondSelectedCurrency: secondSelectedCurrency,
      loadedCurrencyData: loadedCurrencyData,
      selectorVisibleFirstCurrency: selectorVisibleFirstCurrency,
      selectorVisibleSecondCurrency: selectorVisibleSecondCurrency,
      onPressed: () {
        setState(() {
          if (selectorVisibleSecondCurrency) {
            selectorVisibleSecondCurrency = false;
          } else if (selectorVisibleFirstCurrency) {
            selectorVisibleFirstCurrency = false;
          }
        });
      },
      onSelectedItemChanged: (value) {
        setState(() {
          if (selectorVisibleFirstCurrency) {
            firstSelectedCurrency = currencyKeyList[value];
          } else if (selectorVisibleSecondCurrency) {
            secondSelectedCurrency = currencyKeyList[value];
          }
        });

        if (firstSelectedCurrency != null && secondSelectedCurrency != null) {
          convertedCurrency = _convertCurrency(
              firstValue: loadedCurrencyData[firstSelectedCurrency],
              secondValue: loadedCurrencyData[secondSelectedCurrency]);
        }
      },
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

  double _convertCurrency({firstValue, secondValue}) {
    double output;
    output = secondValue / firstValue;
    return output;
  }

  Color a(value) {
    var out;

    if (value == MyThemeKeys.LIGHT) {
      out = Colors.grey;
    } else {
      out = Colors.white;
    }
    return out;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(screenTitle: 'Currency Converter'),
      drawer: MainDrawer(),
      body: FutureBuilder(
          future: _allData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  Container(
                    color: Theme.of(context).primaryColorLight,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'last update: ${snapshot.data.updateDate}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            firstSelectedCurrency != null
                                ? FlagAndCurrencyName(
                                    onTap: () {
                                      selectorVisibleFirstCurrency = true;
                                      setState(() {
                                        _iOSPicker();
                                      });
                                    },
                                    selectedCurrency: firstSelectedCurrency,
                                    textValue: '1 $firstSelectedCurrency',
                                    secondFlag: false,
                                  )
                                //firstFlagAndCurrencyShortName(firstSelectedCurrency)
                                : addCurrencyButton(() {
                                    setState(() {
                                      selectorVisibleFirstCurrency = true;
                                      _iOSPicker();
                                    });
                                  }),
                            (firstSelectedCurrency == null ||
                                    secondSelectedCurrency == null)
                                ? Text(
                                    (firstSelectedCurrency == null &&
                                            secondSelectedCurrency == null)
                                        ? ' add first currency '
                                        : ' add second currency',
                                    style: kFontsTextStyle,
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                      icon: Icon(Icons.swap_vert),
                                      iconSize: 35,
                                      onPressed: () {
                                        var tmp = firstSelectedCurrency;
                                        firstSelectedCurrency =
                                            secondSelectedCurrency;
                                        secondSelectedCurrency = tmp;
                                        setState(() {
                                          convertedCurrency = _convertCurrency(
                                              firstValue: loadedCurrencyData[
                                                  firstSelectedCurrency],
                                              secondValue: loadedCurrencyData[
                                                  secondSelectedCurrency]);
                                        });
                                      },
                                    ),
                                  ),
                            secondSelectedCurrency != null
                                ? FlagAndCurrencyName(
                                    selectedCurrency: secondSelectedCurrency,
                                    onTap: () {
                                      setState(() {
                                        selectorVisibleSecondCurrency = true;
                                        _iOSPicker();
                                      });
                                    },
                                    textValue:
                                        '${convertedCurrency.toStringAsFixed(4)} $secondSelectedCurrency',
                                    secondFlag: true,
                                  )
                                : firstSelectedCurrency != null
                                    ? addCurrencyButton(() {
                                        setState(() {
                                          selectorVisibleSecondCurrency = true;
                                          _iOSPicker();
                                        });
                                      })
                                    : Container(),
                            (firstSelectedCurrency != null &&
                                    secondSelectedCurrency != null)
                                ? IconButton(
                                    icon: Icon(Icons.refresh),
                                    iconSize: 36,
                                    onPressed: () {
                                      setState(() {
                                        firstSelectedCurrency = null;
                                        secondSelectedCurrency = null;
                                      });
                                    },
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: (selectorVisibleFirstCurrency ||
                            selectorVisibleSecondCurrency)
                        ? 2
                        : 0,
                    child: (selectorVisibleFirstCurrency ||
                            selectorVisibleSecondCurrency)
                        ? _iOSPicker()
                        : Container(),
                  ),
                ],
              );
            } else {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.deepPurpleAccent.shade700,
                valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
              ));
            }
          }),
    );
  }
}
