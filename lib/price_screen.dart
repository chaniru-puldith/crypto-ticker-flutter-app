import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String btcRate = '?';
  String selectedCurrency = 'AUD';

  @override
  void initState() {
    super.initState();
    getBTCData('AUD');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('🤑 Coin Ticker'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.blue.shade900,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: CryptoCard(
                  rateValue: btcRate, selectedCurrency: selectedCurrency),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.blue.shade900,
              ),
              height: 150.0,
              padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
              alignment: Alignment.center,
              child: CupertinoPicker(
                looping: true,
                itemExtent: 40.0,
                onSelectedItemChanged: (int index) async {
                  setState(() {
                    selectedCurrency = currenciesList[index];
                    getBTCData(selectedCurrency);
                  });
                },
                children: getCupertinoPickerItems(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getCupertinoPickerItems() {
    return currenciesList
        .map(
          (currency) => Center(
            child: Text(
              currency,
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
          ),
        )
        .toList();
  }

  void getBTCData(currency) async {
    try {
      var data = await CoinData().getCoinData(currency);
      setState(() {
        btcRate = data;
      });
    } catch (e) {
      print(e);
    }
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard(
      {super.key, required this.selectedCurrency, required this.rateValue, re});

  final String rateValue;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
      child: Text(
        '1 BTC = $rateValue $selectedCurrency',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
