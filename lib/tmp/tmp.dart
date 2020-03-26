//Widget _appBody() {
//  return SafeArea(
//    child: Container(
//      child: Center(
//        child: FutureBuilder(
//          future: _allData,
//          builder: (context, snapshot) {
//            if (snapshot.hasData) {
//              return Center(
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    CurrencyIconButton(
//                      onTap: () {
//                        setState(() {
//                          selectorVisibleFirstCurrency = true;
//                        });
//                      },
//                      currencyShortName: 'EUR',
//                    ),
//                    Text(
//                      '1 EUR = ${snapshot.data.allCurrency['PLN'].toStringAsFixed(2)} PLN',
//                      style: TextStyle(fontSize: 20),
//                    ),
//                    CurrencyIconButton(
//                      onTap: () {
//                        setState(() {
//                          selectorVisibleSecondCurrency = true;
//                        });
//                      },
//                      currencyShortName: 'PLN',
//                    ),
//                  ],
//                ),
//              );
//            } else if (snapshot.hasError) {
//              print('error');
//            }
//            return Center(child: CircularProgressIndicator());
//          },
//        ),
//      ),
//    ),
//  );
//}
