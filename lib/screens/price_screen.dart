import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:crypto_ticker/utilities/coin_data.dart';
import 'package:crypto_ticker/main.dart';
import 'package:crypto_ticker/utilities/crypto_card.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String _selectedCurrency = 'AUD';
  bool _isWaiting = false;
  Map<String, String> _cryptoRatesData = {};

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('🤑 Crypto Ticker'),
        backgroundColor: Colors.blue.shade800,
        actions: [
          IconButton(
            icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: () {
              MyApp.themeNotifier.value =
                  MyApp.themeNotifier.value == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _getCryptoCards(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(7.0, 7.0, 7.0, 20.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.blue.shade800,
              ),
              height: 150.0,
              padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
              alignment: Alignment.center,
              child: CupertinoPicker(
                magnification: 1.3,
                looping: true,
                itemExtent: 40.0,
                onSelectedItemChanged: (int index) async {
                  setState(() {
                    _selectedCurrency = currenciesList[index];
                    _getData();
                  });
                },
                children: _getCupertinoPickerItems(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getCupertinoPickerItems() {
    return currenciesList
        .map(
          (currency) => Center(
            child: Text(
              currency,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ),
        )
        .toList();
  }

  List<Widget> _getCryptoCards() {
    List<Widget> cryptoCards = [];

    for (int i = 0; i < cryptoList.length; i++) {
      var crypto = cryptoList[i];
      cryptoCards.add(
        CryptoCard(
          selectedCurrency: _selectedCurrency,
          rateValue: _isWaiting ? '?' : _cryptoRatesData[crypto],
          cryptoCurrency: crypto,
        ),
      );
    }

    return cryptoCards;
  }

  void _getData() async {
    _isWaiting = true;

    try {
      var data =
          await CoinData().getCoinData(selectedCurrency: _selectedCurrency);
      _isWaiting = false;
      setState(() {
        _cryptoRatesData = data;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
