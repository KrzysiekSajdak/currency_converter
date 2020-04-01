class CurrencyConverterBrain {

  // shows converted currency value loaded from API
  double convertCurrency({firstValue, secondValue}) {
    double output;
    output = secondValue / firstValue;
    return output;
  }

}