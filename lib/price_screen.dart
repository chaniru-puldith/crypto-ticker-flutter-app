import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'main.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';
  bool isWaiting = false;
  Map<String, String> cryptoRatesData = {};

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('🤑 Coin Ticker'),
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
            children: getCryptoCards(),
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
                    selectedCurrency = currenciesList[index];
                    getData();
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
                color: Colors.white,
              ),
            ),
          ),
        )
        .toList();
  }

  List<Widget> getCryptoCards() {
    List<Widget> cryptoCards = [];

    for (int i = 0; i < cryptoList.length; i++) {
      var crypto = cryptoList[i];
      cryptoCards.add(
        CryptoCard(
          selectedCurrency: selectedCurrency,
          rateValue: isWaiting ? '?' : cryptoRatesData[crypto],
          cryptoCurrency: crypto,
        ),
      );
    }

    return cryptoCards;
  }

  void getData() async {
    isWaiting = true;

    try {
      var data =
          await CoinData().getCoinData(selectedCurrency: selectedCurrency);
      isWaiting = false;
      setState(() {
        cryptoRatesData = data;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    super.key,
    required this.selectedCurrency,
    required this.rateValue,
    required this.cryptoCurrency,
  });

  final String selectedCurrency;
  final String? rateValue;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.blue.shade800,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
              child: Text(
                '1 $cryptoCurrency = $rateValue $selectedCurrency',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
