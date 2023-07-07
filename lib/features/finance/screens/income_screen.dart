import 'package:bootcamp_flutter/themes/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/finance_controller.dart';

class IncomeScreen extends ConsumerStatefulWidget {
  static final routeName = "/incomeScreen";

  @override
  _IncomeScreenState createState() => _IncomeScreenState();
}

class _IncomeScreenState extends ConsumerState<IncomeScreen> {
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
                'Enter Income',
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
                      value: 'salary',
                      child: Text('Salary',
                          style: TextStyle(color: Palette.categoryText))),
                  DropdownMenuItem(
                      value: 'freelance',
                      child: Text('Freelance',
                          style: TextStyle(color: Palette.categoryText))),
                  DropdownMenuItem(
                      value: 'personal',
                      child: Text('Personal',
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
                      MaterialStateProperty.all(Palette.buttonText),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ref.read(financeControllerProvider.notifier).addFinance(
                          description!,
                          category!,
                          "income",
                          double.parse(amount!),
                          context,
                        );
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
