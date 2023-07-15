import 'package:flutter/material.dart';
import '../../themes/palette.dart';

class Constants {
  static const appLogo = "assets/images/logo.png";
  static const profilePicture = "assets/images/profile_picture.png";

  static List<DropdownMenuItem> expenseTypeDropItems = [
    DropdownMenuItem(
        value: 'home',
        child: Text('Home and Living',
            style: TextStyle(color: Palette.categoryText))),
    DropdownMenuItem(
        value: 'food',
        child: Text('Food', style: TextStyle(color: Palette.categoryText))),
    DropdownMenuItem(
        value: 'Transportation',
        child: Text('Transportation',
            style: TextStyle(color: Palette.categoryText))),
    DropdownMenuItem(
        value: 'health',
        child: Text('Health', style: TextStyle(color: Palette.categoryText))),
    DropdownMenuItem(
        value: 'education',
        child:
            Text('Education', style: TextStyle(color: Palette.categoryText))),
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
        child: Text('Travel', style: TextStyle(color: Palette.categoryText))),
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
        child: Text('Other', style: TextStyle(color: Palette.categoryText))),
  ];

  static List<DropdownMenuItem> incomeTypeDropItems = [
    DropdownMenuItem(
        value: 'salary',
        child: Text('Salary', style: TextStyle(color: Palette.categoryText))),
    DropdownMenuItem(
        value: 'freelance',
        child:
            Text('Freelance', style: TextStyle(color: Palette.categoryText))),
    DropdownMenuItem(
        value: 'personal',
        child: Text('Personal', style: TextStyle(color: Palette.categoryText))),
  ];
}
