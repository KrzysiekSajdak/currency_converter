import 'package:http/http.dart' as http;
import 'dart:convert';

class AllCurrency {
  final Map allCurrency;
  final String updateDate;
  final String currencyBase;

  AllCurrency({this.allCurrency, this.updateDate, this.currencyBase});

  factory AllCurrency.fromJson(Map<String, dynamic> json) {
    Map output = {};
    String date;
    String base;

    output.addAll(json['rates']);
    date = json['date'];
    base = json['base'];
    print(date);

    return AllCurrency(
      updateDate: date,
      currencyBase: base,
      allCurrency: output,
    );
  }

  Future<AllCurrency> getData(url) async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return AllCurrency.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed load data');
    }
  }
}