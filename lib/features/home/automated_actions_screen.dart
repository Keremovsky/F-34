import 'dart:ffi';

import 'package:bootcamp_flutter/themes/palette.dart';
import 'package:flutter/material.dart';


class AutomatedActionsScreen extends StatefulWidget {
  const AutomatedActionsScreen({super.key});

  @override
  State<AutomatedActionsScreen> createState() => __AutomatedActionsScreenStateState();
}

class __AutomatedActionsScreenStateState extends State<AutomatedActionsScreen> {
  final _formKey = GlobalKey<FormState>();
    Double? amount;
    String? action;
    String? category;
    String? description;
    String? frequency;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 90,),
              Container(
                child: Text(
                  'Automated Actions',
                  style: TextStyle(
                    color: Palette.buttonText,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 65,),
              Container(
                height: 62,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Amount",
                    labelStyle: TextStyle(
                      color: Palette.textFieldText,
                      fontSize: 20,
                    ),
                    fillColor: Palette.textFieldBackground,
                    filled: true,
                  ),
                  onSaved: (value) => amount = value as Double?,
                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: 62,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Type of Action',
                    labelStyle: TextStyle(
                      color: Palette.textFieldText,
                      fontSize: 20,
                    ),
                    fillColor: Palette.textFieldBackground,
                    filled: true,
                    border: InputBorder.none,
                  ),
                  dropdownColor: Palette.categoryBackground,
                  items: [
                    DropdownMenuItem(
                        value: 'expense',
                        child: Text('Expense',
                            style: TextStyle(color: Palette.categoryText))),
                    DropdownMenuItem(
                        value: 'income',
                        child: Text('Income',
                            style: TextStyle(color: Palette.categoryText))),
                  ],
                  onChanged: (value) {
                    setState(() {
                      action = value as String?;
                    });
                  },
                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: 62,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)),
                child: action == 'expense'
                    ? expenseOption()
                    : action == 'income'
                        ? incomeOption()
                        : nullOption(),
              ),
              SizedBox(height: 20,),
              Container(
                height: 62,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Description",
                    labelStyle: TextStyle(
                      color: Palette.textFieldText,
                      fontSize: 20,
                    ),
                    fillColor: Palette.textFieldBackground,
                    filled: true,
                  ),
                  onSaved: (value) => description = value,
                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: 62,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Frequency',
                    labelStyle: TextStyle(
                      color: Palette.textFieldText,
                      fontSize: 20,
                    ),
                    fillColor: Palette.textFieldBackground,
                    filled: true,
                    border: InputBorder.none,
                  ),
                  dropdownColor: Palette.categoryBackground,
                  items: [
                    DropdownMenuItem(
                        value: 'monthly',
                        child: Text('Monthly',
                            style: TextStyle(color: Palette.categoryText))),
                    DropdownMenuItem(
                        value: 'weekly',
                        child: Text('Weekly',
                            style: TextStyle(color: Palette.categoryText))),
                  ],
                  onChanged: (value) => frequency = value as String?,
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Container(
                  width: double.infinity,
                  child: RawMaterialButton(
                      fillColor: Palette.buttonBackground,
                      elevation: 0.0,
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        }
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Palette.buttonText,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class expenseOption extends StatefulWidget {
  const expenseOption({super.key});

  @override
  State<expenseOption> createState() => _expenceOptionState();
}

class _expenceOptionState extends State<expenseOption> {
    String? category;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Category',
                    labelStyle: TextStyle(
                      color: Palette.textFieldText,
                      fontSize: 20,
                    ),
                    fillColor: Palette.textFieldBackground,
                    filled: true,
                    border: InputBorder.none,
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
    );
  }
}

class incomeOption extends StatefulWidget {
  const incomeOption({super.key});

  @override
  State<incomeOption> createState() => _incomeOptionState();
}

class _incomeOptionState extends State<incomeOption> {
  String? category;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButtonFormField(
                decoration: InputDecoration(
                    labelText: 'Category',
                    labelStyle: TextStyle(
                      color: Palette.textFieldText,
                      fontSize: 20,
                    ),
                    fillColor: Palette.textFieldBackground,
                    filled: true,
                    border: InputBorder.none,
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
    );
  }
}

class nullOption extends StatelessWidget {
  const nullOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 62,
      decoration: BoxDecoration(
        color: Palette.textFieldBackground,
      ),
      child: RawMaterialButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Firstly, select the type of action.'),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Category",
                style: TextStyle(
                  color: Palette.textFieldText,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}