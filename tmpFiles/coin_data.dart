//import 'package:http/http.dart' as http;
//import 'dart:convert';
//
//var coinAPIURL =
//    'https://api.exchangeratesapi.io/latest?symbols=$firstCurrency,$secondCurrency';
//
//String firstCurrency = "PLN";
//String secondCurrency = "GBP";
//
//class CoinData {
//
//  final double firstCurrencyRate;
//  final double secondCurrencyRate;
//
//  CoinData({this.firstCurrencyRate, this.secondCurrencyRate});
//
//  factory CoinData.fromJson(Map<String, dynamic> json) {
//    return CoinData(
//      firstCurrencyRate: json['rates'][firstCurrency],
//      secondCurrencyRate: json['rates'][secondCurrency],
//    );
//  }
//  Future<CoinData> getData(url) async {
//    final response = await http.get(url);
//
//    if (response.statusCode == 200) {
//      return CoinData.fromJson(json.decode(response.body));
//    } else {
//      throw Exception('Failed load data');
//    }
//  }
//}
