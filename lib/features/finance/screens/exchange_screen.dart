import 'package:bootcamp_flutter/themes/palette.dart';
import 'package:flutter/material.dart';

class ExchangeScreen extends StatefulWidget {
  static const routeName = "/exchangeScreen";

  const ExchangeScreen({super.key});

  @override
  _ExchangeScreenState createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  final _formKey = GlobalKey<FormState>();
  String? category;
  // Declare variables to store the buying and selling amounts
  double buyingAmount = 0.0;
  double sellingAmount = 0.0;

  // Declare variables for exchange rates
  double dollarRate = 0.0;
  double euroRate = 0.0;
  double poundRate = 0.0;
  double goldRate = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Palette.background, // Set the background color
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 36.0),
            // Add exchange rate information
            Text(
              'Exchange Rates',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Palette.titleText,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Dollar Rate: $dollarRate',
              style: TextStyle(color: Palette.titleText),
            ),
            Text(
              'Euro Rate: $euroRate',
              style: TextStyle(color: Palette.titleText),
            ),
            Text(
              'Pound Rate: $poundRate',
              style: TextStyle(color: Palette.titleText),
            ),
            Text(
              'Gold Rate: $goldRate',
              style: TextStyle(color: Palette.titleText),
            ),
            SizedBox(height: 26.0),
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Category',
                fillColor: Palette.textFieldBackground,
                filled: true,
              ),
              dropdownColor: Palette.categoryBackground,
              items: [
                DropdownMenuItem(
                    child: Text('Dollar',
                        style: TextStyle(color: Palette.categoryText)),
                    value: 'dollar'),
                DropdownMenuItem(
                    child: Text('Euro',
                        style: TextStyle(color: Palette.categoryText)),
                    value: 'euro'),
                DropdownMenuItem(
                    child: Text('Sterling',
                        style: TextStyle(color: Palette.categoryText)),
                    value: 'sterling'),
                DropdownMenuItem(
                    child: Text('Gold',
                        style: TextStyle(color: Palette.categoryText)),
                    value: 'gold'),
              ],
              onChanged: (value) => category = value as String?,
            ),
            SizedBox(height: 16),
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
            SizedBox(height: 16.0),
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
            SizedBox(height: 16),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Palette.buttonBackground),
                foregroundColor: MaterialStateProperty.all(Palette.buttonText),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
