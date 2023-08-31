import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getCoinData(currency) async {
    String stringUrl = 'https://rest.coinapi.io/v1/exchangerate/BTC/$currency';
    String apiKey = dotenv.get('API_KEY');

    final apiUrl = Uri.parse('$stringUrl?apikey=$apiKey');
    print(apiUrl.toString());

    http.Response response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      double lastPrice = jsonResponse['rate'];
      return lastPrice.toStringAsFixed(2);
    } else {
      return "Error";
    }
  }
}
