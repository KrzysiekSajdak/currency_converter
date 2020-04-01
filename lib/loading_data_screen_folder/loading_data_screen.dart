import 'package:currencyconverter/currency_converter_screen_folder/currency_converter_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:currencyconverter/currency_converter_screen_folder/all_currency.dart';
import 'package:currencyconverter/const_files/const_data.dart';

class LoadingDataScreen extends StatefulWidget {
  @override
  _LoadingDataScreenState createState() => _LoadingDataScreenState();
}

class _LoadingDataScreenState extends State<LoadingDataScreen> {

  AllCurrency allCurrency = AllCurrency();
  Map loadedCurrencyData = {};
  List currencyKeyList = [];
  String currencyLastUpdateDate;

  void fetchCurrencyData() async {
    try {
      var data = await AllCurrency().getData(coinURL);
      loadedCurrencyData = data.allCurrency;
      loadedCurrencyData.addAll({"EUR": 1});
      currencyLastUpdateDate = data.updateDate;

      for (var item in loadedCurrencyData.keys) {
        currencyKeyList.add(item.toString());
      }

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return CurrencyConverterMainScreen(loadedCurrencyData: loadedCurrencyData, currencyKeyList: currencyKeyList, updateDate: currencyLastUpdateDate,);

      }));
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    fetchCurrencyData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading...'),
      ),
      body:  Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.deepPurpleAccent.shade700,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
        ),
      ),
    );


  }
}
