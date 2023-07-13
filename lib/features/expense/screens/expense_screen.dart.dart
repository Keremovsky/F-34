import 'package:bootcamp_flutter/themes/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ExpenseScreen extends StatefulWidget {
  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  String? amount;
  String? description;
  String? category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 16),
              Text(
                'Enter Outcome',
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
                dropdownColor: Palette.categoryBackground,
                items: [
                  DropdownMenuItem(child: Text('Home and Living', style: TextStyle(color: Palette.categoryText)), value: 'home'),
                  DropdownMenuItem(child: Text('Food', style: TextStyle(color: Palette.categoryText)), value: 'food'),
                  DropdownMenuItem(child: Text('Transportation', style: TextStyle(color: Palette.categoryText)), value: 'Transportation'),
                  DropdownMenuItem(child: Text('Health', style: TextStyle(color: Palette.categoryText)), value: 'health'),
                  DropdownMenuItem(child: Text('Education', style: TextStyle(color: Palette.categoryText)), value: 'education'),
                  DropdownMenuItem(child: Text('Personal Care and Clothing', style: TextStyle(color: Palette.categoryText)), value: 'personalcare'),
                  DropdownMenuItem(child: Text('Entertainment and Hobbies', style: TextStyle(color: Palette.categoryText)), value: 'entertainment'),
                  DropdownMenuItem(child: Text('Travel', style: TextStyle(color: Palette.categoryText)), value: 'travel'),
                  DropdownMenuItem(child: Text('Debt and Loan Payments', style: TextStyle(color: Palette.categoryText)), value: 'debt'),
                  DropdownMenuItem(child: Text('Insurance and Investments', style: TextStyle(color: Palette.categoryText)), value: 'investments'),
                  DropdownMenuItem(child: Text('Gifts and Donations', style: TextStyle(color: Palette.categoryText)), value: 'gifts'),
                  DropdownMenuItem(child: Text('Other', style: TextStyle(color: Palette.categoryText)), value: 'other'),
                ],
                onChanged: (value) => category = value as String?,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Palette.buttonBackground),
                  foregroundColor:
                      MaterialStateProperty.all(Palette.categoryText),
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
      ),
    );
  }
}