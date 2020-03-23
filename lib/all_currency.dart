import 'package:http/http.dart' as http;
import 'dart:convert';

class AllCurrency {
  final Map allCurrency;

  AllCurrency({this.allCurrency});

  factory AllCurrency.fromJson(Map<String, dynamic> json) {
    Map output = {};
    output.addAll(json['rates']);

    return AllCurrency(

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