import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class IOSCurrencyPicker extends StatelessWidget {
  final selectorVisibleFirstCurrency;
  final selectorVisibleSecondCurrency;
  final firstSelectedCurrency;
  final secondSelectedCurrency;
  final currencyKeyList;
  final loadedCurrencyData;
  final onPressed;
  final onSelectedItemChanged;

  IOSCurrencyPicker(
      {@required this.selectorVisibleFirstCurrency,
      @required this.selectorVisibleSecondCurrency,
      @required this.firstSelectedCurrency,
      @required this.secondSelectedCurrency,
      @required this.currencyKeyList,
      @required this.loadedCurrencyData,
      @required this.onPressed,
      @required this.onSelectedItemChanged});

  Widget iOSPicker() {

    String pickerLabel() {
      String output;
      if (selectorVisibleFirstCurrency) {
        output = "first currency";
      } else if (selectorVisibleSecondCurrency) {
        output = "second currency";
      }
      else {
        output = "select";
      }
      return output;
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
                      onPressed: onPressed,
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
              onSelectedItemChanged: onSelectedItemChanged,
              itemBuilder: (BuildContext context, int index) {
                return Text(
                  currencyKeyList[index],
                  style: TextStyle(color: Colors.white, fontSize: 20),
                );
              }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return iOSPicker();
  }
}
