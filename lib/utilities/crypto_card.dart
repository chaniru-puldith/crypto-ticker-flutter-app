import 'package:flutter/material.dart';

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
