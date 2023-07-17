import 'package:bootcamp_flutter/themes/palette.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExchangeScreen extends StatefulWidget {
  static final routeName = "/exchangeScreen";

  @override
  _ExchangeScreenState createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic>? exchangeRates;

  Future<void> fetchExchangeRates() async {
    var response = await http.get(
      Uri.parse('https://api.exchangerate-api.com/v4/latest/TRY'),
    );

    if (response.statusCode == 200) {
      setState(() {
        exchangeRates = json.decode(response.body)['rates'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchExchangeRates();
  }

  @override
  Widget build(BuildContext context) {
    String? category;
    double buyingAmount = 0.0;
    double sellingAmount = 0.0;

    return Scaffold(
      backgroundColor: Palette.background,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 36.0),
              // Add exchange rate information
              Text(
                'Exchange Rates',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Palette.titleText,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Dollar Rate: ${exchangeRates?['USD'] != null ? exchangeRates!['USD'] > 1 ? '+' : '-' : ''}${exchangeRates?['USD'] ?? ""}',
                style: TextStyle(color: Palette.titleText),
              ),
              Text(
                'Euro Rate: ${exchangeRates?['EUR'] != null ? exchangeRates!['EUR'] > 1 ? '+' : '-' : ''}${exchangeRates?['EUR'] ?? ""}',
                style: TextStyle(color: Palette.titleText),
              ),
              Text(
                'Pound Rate: ${exchangeRates?['GBP'] != null ? exchangeRates!['GBP'] > 1 ? '+' : '-' : ''}${exchangeRates?['GBP'] ?? ""}',
                style: TextStyle(color: Palette.titleText),
              ),

              const SizedBox(height: 26.0),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Category',
                  fillColor: Palette.textFieldBackground,
                  filled: true,
                ),
                dropdownColor: Palette.categoryBackground,
                items: [
                  DropdownMenuItem(
                      value: 'dollar',
                      child: Text('Dollar',
                          style: TextStyle(color: Palette.categoryText))),
                  DropdownMenuItem(
                      value: 'euro',
                      child: Text('Euro',
                          style: TextStyle(color: Palette.categoryText))),
                  DropdownMenuItem(
                      value: 'pound',
                      child: Text('Pound',
                          style: TextStyle(color: Palette.categoryText))),
                  DropdownMenuItem(
                      value: 'gold',
                      child: Text('Gold',
                          style: TextStyle(color: Palette.categoryText))),
                ],
                onChanged: (value) => category = value as String?,
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (value) {
                  setState(() {
                    buyingAmount = double.tryParse(value) ?? 0.0;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Palette.textFieldBackground,
                  labelText: 'Buying Amount',
                  labelStyle: TextStyle(color: Palette.textFieldText),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                onChanged: (value) {
                  setState(() {
                    sellingAmount = double.tryParse(value) ?? 0.0;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Palette.textFieldBackground,
                  labelText: 'Selling Amount',
                  labelStyle: TextStyle(color: Palette.textFieldText),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Palette.buttonBackground),
                  foregroundColor:
                      MaterialStateProperty.all(Palette.buttonText),
                ),
                onPressed: () {},
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
