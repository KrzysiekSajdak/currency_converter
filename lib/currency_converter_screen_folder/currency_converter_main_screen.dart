import 'package:currencyconverter/app_brain/currency_converter_brain.dart';
import 'package:currencyconverter/currency_converter_screen_folder/drawer.dart';
import 'package:currencyconverter/currency_converter_screen_folder/flag_and_currency_name.dart';
import 'package:currencyconverter/currency_converter_screen_folder/ios_currency_picker.dart';
import 'package:currencyconverter/themes_data/my_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:currencyconverter/const_files/const_data.dart';
import 'package:currencyconverter/all_pages_widgets/app_bar.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class CurrencyConverterMainScreen extends StatefulWidget {
  final currencyKeyList;
  final loadedCurrencyData;
  final updateDate;

  CurrencyConverterMainScreen(
      {@required this.currencyKeyList,
      @required this.loadedCurrencyData,
      @required this.updateDate});

  @override
  _CurrencyConverterMainScreenState createState() =>
      _CurrencyConverterMainScreenState();
}

class _CurrencyConverterMainScreenState
    extends State<CurrencyConverterMainScreen> {
  bool selectorVisibleFirstCurrency = false;
  bool selectorVisibleSecondCurrency = false;
  String firstSelectedCurrency;
  String secondSelectedCurrency;
  bool secondFlag;
  double convertedCurrency = 0;
  var baseCurrencyValue = 1;

  CurrencyConverterBrain _currencyConverterBrain = CurrencyConverterBrain();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    firstSelectedCurrency = "GBP";
    secondSelectedCurrency = "PLN";
    convertedCurrency = (_currencyConverterBrain.convertCurrency(
            firstValue: widget.loadedCurrencyData[firstSelectedCurrency],
            secondValue: widget.loadedCurrencyData[secondSelectedCurrency]) *
        baseCurrencyValue);
    super.initState();
  }

  IOSCurrencyPicker _iOSPicker() {
    return IOSCurrencyPicker(
      currencyKeyList: widget.currencyKeyList,
      firstSelectedCurrency: firstSelectedCurrency,
      secondSelectedCurrency: secondSelectedCurrency,
      loadedCurrencyData: widget.loadedCurrencyData,
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
            firstSelectedCurrency = widget.currencyKeyList[value];
          } else if (selectorVisibleSecondCurrency) {
            secondSelectedCurrency = widget.currencyKeyList[value];
          }
        });

        if (firstSelectedCurrency != null && secondSelectedCurrency != null) {
          convertedCurrency = (_currencyConverterBrain.convertCurrency(
                  firstValue: widget.loadedCurrencyData[firstSelectedCurrency],
                  secondValue:
                      widget.loadedCurrencyData[secondSelectedCurrency]) *
              baseCurrencyValue);
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

  String value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: appBar(screenTitle: 'Currency Converter'),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColorLight,
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'last update: ${widget.updateDate}',
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
                            onLongTap: () {
                              setState(() {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Add amount'),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        content: Container(
                                          height: 50,
                                          child: Column(
                                            children: <Widget>[
                                              TextField(
                                                onChanged: (txt) {
                                                  value = txt;
                                                },
                                                cursorColor: currentTheme == MyThemeKeys.DARK ? Colors.white : kMainPurple,
                                                decoration: InputDecoration(
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: currentTheme ==
                                                                  MyThemeKeys
                                                                      .DARK
                                                              ? Colors.white
                                                              : kMainPurple)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: currentTheme == MyThemeKeys.DARK ? Colors.white : kMiddlePurple),
                                                  ),
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('cancel',
                                                style: TextStyle(
                                                    color: currentTheme == MyThemeKeys.DARK ? Colors.white : Colors.red.shade400,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
//                                              baseCurrencyValue = 1;
//                                              convertedCurrency = (_currencyConverterBrain
//                                                      .convertCurrency(
//                                                          firstValue: widget
//                                                                  .loadedCurrencyData[
//                                                              firstSelectedCurrency],
//                                                          secondValue: widget
//                                                                  .loadedCurrencyData[
//                                                              secondSelectedCurrency]) *
//                                                  baseCurrencyValue);
                                              setState(() {
                                                Navigator.pop(context);
                                              });
                                            },
                                          ),
                                          FlatButton(
                                            child: Text('done',
                                                style: TextStyle(
                                                    color: currentTheme == MyThemeKeys.DARK ? Colors.white : kMainPurple,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
                                              baseCurrencyValue =
                                                  int.parse(value);
                                              convertedCurrency = (_currencyConverterBrain
                                                      .convertCurrency(
                                                          firstValue: widget
                                                                  .loadedCurrencyData[
                                                              firstSelectedCurrency],
                                                          secondValue: widget
                                                                  .loadedCurrencyData[
                                                              secondSelectedCurrency]) *
                                                  baseCurrencyValue);
                                              setState(() {
                                                Navigator.pop(context);
                                              });
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              });
                            },
                            selectedCurrency: firstSelectedCurrency,
                            textValue: '$firstSelectedCurrency',
                            firstCurrencyValue: baseCurrencyValue,
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
                                firstSelectedCurrency = secondSelectedCurrency;
                                secondSelectedCurrency = tmp;
                                setState(() {
                                  convertedCurrency =
                                      (_currencyConverterBrain.convertCurrency(
                                              firstValue:
                                                  widget.loadedCurrencyData[
                                                      firstSelectedCurrency],
                                              secondValue:
                                                  widget.loadedCurrencyData[
                                                      secondSelectedCurrency]) *
                                          baseCurrencyValue);
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
                                baseCurrencyValue = 1;
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
            flex:
                (selectorVisibleFirstCurrency || selectorVisibleSecondCurrency)
                    ? 2
                    : 0,
            child:
                (selectorVisibleFirstCurrency || selectorVisibleSecondCurrency)
                    ? _iOSPicker()
                    : Container(),
          ),
        ],
      ),
    );
  }
}
