import 'package:flutter/material.dart';
import 'palette.dart';

class IncomeScreen extends StatefulWidget {
  @override
  _IncomeScreenState createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  final _formKey = GlobalKey<FormState>();
  String? amount;
  String? description;
  String? category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        backgroundColor: Palette.background,
        elevation: 0,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 16),
              Text(
                'Enter Income',
                style: TextStyle(
                  fontSize: 24,
                  color: Palette.titleText,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                  fillColor: Palette.textFieldBackground,
                  filled: true,
                ),
                onSaved: (value) => amount = value,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  fillColor: Palette.textFieldBackground,
                  filled: true,
                ),
                onSaved: (value) => description = value,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Category',
                  fillColor: Palette.textFieldBackground,
                  filled: true,
                ),
                items: [
                  DropdownMenuItem(child: Text('Salary'), value: 'salary'),
                  DropdownMenuItem(child: Text('Freelance'), value: 'freelance'),
                  DropdownMenuItem(child: Text('Personal'), value: 'personal'),
                ],
                onChanged: (value) => category = value as String?,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Palette.buttonBackground),
                  foregroundColor:
                      MaterialStateProperty.all(Palette.buttonText),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Do something with amount, description, and category
                  }
                },
                child: Text('Add to Wallet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}