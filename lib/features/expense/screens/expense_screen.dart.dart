import 'package:bootcamp_flutter/themes/palette.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatefulWidget {
  static final routeName = "/expenseScreen";

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
              const SizedBox(height: 16),
              Text(
                'Enter Outcome',
                style: TextStyle(
                  fontSize: 24,
                  color: Palette.titleText,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                  fillColor: Palette.textFieldBackground,
                  filled: true,
                ),
                onSaved: (value) => amount = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  fillColor: Palette.textFieldBackground,
                  filled: true,
                ),
                onSaved: (value) => description = value,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Category',
                  fillColor: Palette.textFieldBackground,
                  filled: true,
                ),
                dropdownColor: Palette.categoryBackground,
                items: [
                  DropdownMenuItem(
                      value: 'home',
                      child: Text('Home and Living',
                          style: TextStyle(color: Palette.categoryText))),
                  DropdownMenuItem(
                      value: 'food',
                      child: Text('Food',
                          style: TextStyle(color: Palette.categoryText))),
                  DropdownMenuItem(
                      value: 'Transportation',
                      child: Text('Transportation',
                          style: TextStyle(color: Palette.categoryText))),
                  DropdownMenuItem(
                      value: 'health',
                      child: Text('Health',
                          style: TextStyle(color: Palette.categoryText))),
                  DropdownMenuItem(
                      value: 'education',
                      child: Text('Education',
                          style: TextStyle(color: Palette.categoryText))),
                  DropdownMenuItem(
                      value: 'personalcare',
                      child: Text('Personal Care and Clothing',
                          style: TextStyle(color: Palette.categoryText))),
                  DropdownMenuItem(
                      value: 'entertainment',
                      child: Text('Entertainment and Hobbies',
                          style: TextStyle(color: Palette.categoryText))),
                  DropdownMenuItem(
                      value: 'travel',
                      child: Text('Travel',
                          style: TextStyle(color: Palette.categoryText))),
                  DropdownMenuItem(
                      value: 'debt',
                      child: Text('Debt and Loan Payments',
                          style: TextStyle(color: Palette.categoryText))),
                  DropdownMenuItem(
                      value: 'investments',
                      child: Text('Insurance and Investments',
                          style: TextStyle(color: Palette.categoryText))),
                  DropdownMenuItem(
                      value: 'gifts',
                      child: Text('Gifts and Donations',
                          style: TextStyle(color: Palette.categoryText))),
                  DropdownMenuItem(
                      value: 'other',
                      child: Text('Other',
                          style: TextStyle(color: Palette.categoryText))),
                ],
                onChanged: (value) => category = value as String?,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Palette.buttonBackground),
                  foregroundColor:
                      MaterialStateProperty.all(Palette.categoryText),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
