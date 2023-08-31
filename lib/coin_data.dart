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

const String apiUrl = 'https://rest.coinapi.io/v1/exchangerate';
final String apiKey = dotenv.get('API_KEY2');

class CoinData {
  Future getCoinData({required String selectedCurrency}) async {
    Map<String, String> ratesData = {};

    for (String crypto in cryptoList) {
      final requestUrl =
          Uri.parse('$apiUrl/$crypto/$selectedCurrency?apikey=$apiKey');
      print(requestUrl.toString());

      http.Response response = await http.get(requestUrl);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        double lastPrice = jsonResponse['rate'];
        ratesData[crypto] = lastPrice.toStringAsFixed(2);
      } else {
        print(response.statusCode);
        throw "Error";
      }
    }

    return ratesData;
  }
}
