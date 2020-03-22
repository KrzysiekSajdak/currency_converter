//import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';
//import 'coin_data.dart';
//import 'dart:io' show Platform;
//import 'package:flutter/services.dart';
//import 'package:currencyconverter/currencies_list.dart';
//
//class PriceScreen extends StatefulWidget {
//  @override
//  _PriceScreenState createState() => _PriceScreenState();
//}
//
//class _PriceScreenState extends State<PriceScreen> {
//  var addFirstValue;
//  var addSecondValue;
//
//  CoinData _coinData = CoinData();
//
//  DropdownButton<String> androidDropdown() {
//    List<DropdownMenuItem<String>> dropdownItems = [];
//    for (String currency in currenciesList) {
//      var newItem = DropdownMenuItem(
//        child: Text(currency),
//        value: currency,
//      );
//      dropdownItems.add(newItem);
//    }
//
//    return DropdownButton<String>(
//      value: secondCurrency,
//      items: dropdownItems,
//      onChanged: (value) {
//        setState(() {
//          secondCurrency = value;
//        });
//      },
//    );
//  }
//
//  CupertinoPicker iOSPicker() {
//    List<Text> pickerItems = [];
//    for (String currency in currenciesList) {
//      pickerItems.add(Text(
//        currency,
//        style: TextStyle(color: Colors.white),
//      ));
//    }
//
//    return CupertinoPicker(
//      backgroundColor: ThemeData.dark().primaryColor,
//      itemExtent: 26.0,
//      onSelectedItemChanged: (selectedIndex) {
//        firstCurrency = "PLN";
//        secondCurrency = currenciesList[selectedIndex];
//        if (secondCurrency != "EUR") {
//          coinAPIURL =
//              'https://api.exchangeratesapi.io/latest?symbols=$firstCurrency,$secondCurrency';
//        } else {
//          coinAPIURL =
//              'https://api.exchangeratesapi.io/latest?base=$firstCurrency';
//        }
//
//        setState(() {
//          myData = _coinData.getData(coinAPIURL);
//        });
//      },
//      children: pickerItems,
//    );
//  }
//
//  Future<CoinData> myData;
// var a;
// var b;
//
//  Future<void> getIt() async {
//    try {
//      CoinData c = await CoinData().getData(coinAPIURL);
//      a = c.firstCurrencyRate;
//      b = c.secondCurrencyRate;
//    } catch (e) {
//      print(e);
//    }
//
//  }
//  @override
//  void initState() {
//    super.initState();
//    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//    currenciesList.sort();
//    myData = _coinData.getData(coinAPIURL);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Currency Converter'),
//      ),
//      body: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        crossAxisAlignment: CrossAxisAlignment.center,
//        children: <Widget>[
//          Expanded(
//            flex: 2,
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                addFirstValue == null
//                    ? IconButton(
//                        icon: Icon(
//                          Icons.add_circle_outline,
//                          size: 26,
//                        ),
//                        onPressed: () {
//                         setState(() {
//                           addFirstValue = secondCurrency;
//                           print(addFirstValue);
//                         });
//                        },
//                      )
//                    : Text('1 $addFirstValue '),
//                (addSecondValue == null || addFirstValue == null)
//                    ? Text(
//                        'add value',
//                        style: TextStyle(fontSize: 22),
//                      )
//                    : Text(' = '),
//                addSecondValue == null
//                    ? IconButton(
//                        icon: Icon(
//                          Icons.add_circle_outline,
//                          size: 26,
//                        ),
//                        onPressed: () {
//                          setState(() {
//                            addSecondValue = secondCurrency;
//                            myData = _coinData.getData('https://api.exchangeratesapi.io/latest?symbols=$addFirstValue,$addSecondValue');
//
//                          });
//                        },
//                      )
//                    : Text('$myData $secondCurrency'),
//              ],
//            ),
//          ),
//          Expanded(
//            flex: 5,
//            child: FutureBuilder<CoinData>(
//              future: myData,
//              builder: (context, snapshot) {
//                if (snapshot.hasData) {
//                  return Padding(
//                    padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 18.0),
//                    child: Card(
//                      elevation: 5.0,
//                      shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(20.0),
//                      ),
//                      child: Padding(
//                        padding: EdgeInsets.symmetric(
//                            vertical: 15.0, horizontal: 28.0),
//                        child: FittedBox(
//                          fit: BoxFit.fitWidth,
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              Padding(
//                                padding: const EdgeInsets.only(right: 12),
//                                child: Image.asset(
//                                  "assets/images/$firstCurrency.png",
//                                  height: 26,
//                                ),
//                              ),
//                              Text(
//                                //TODO: Update the Text Widget with the live bitcoin data here.
//                                '1 $firstCurrency  =  ${((snapshot.data.firstCurrencyRate) / (snapshot.data.secondCurrencyRate)).toStringAsFixed(2)} $secondCurrency',
//                                textAlign: TextAlign.center,
//                                style: TextStyle(
//                                  fontSize: 25.0,
//                                ),
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.only(left: 12),
//                                child: Image.asset(
//                                  "assets/images/$secondCurrency.png",
//                                  height: 26,
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
//                    ),
//                  );
//                } else if (snapshot.hasError) {
//                  print('Please select currency');
//                  return Container(child: Text("${snapshot.error}".toString()));
//                }
//
//                return Center(
//                  child: CircularProgressIndicator(),
//                );
//              },
//            ),
//          ),
//          Expanded(
//            flex: 4,
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: <Widget>[
//                Container(
//                  child: Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Text('Select currency'),
//                  ),
//                  color: ThemeData.dark().primaryColor,
//                  height: 46.0,
//                  alignment: Alignment.center,
//                ),
//                Container(
//                  color: ThemeData.dark().primaryColor,
//                  height: 180.0,
//                  alignment: Alignment.center,
//                  padding: EdgeInsets.only(bottom: 30.0),
//                  child: Platform.isIOS ? iOSPicker() : androidDropdown(),
//                ),
//              ],
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}
