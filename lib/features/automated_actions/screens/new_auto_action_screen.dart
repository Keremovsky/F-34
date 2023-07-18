import 'package:bootcamp_flutter/core/constants/constants.dart';
import 'package:bootcamp_flutter/features/automated_actions/controller/auto_action_controller.dart';
import 'package:bootcamp_flutter/themes/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

late String category;

class CreateAutomatedActionScreen extends ConsumerStatefulWidget {
  static const routeName = "/automatedActionsScreen";

  const CreateAutomatedActionScreen({super.key});

  @override
  ConsumerState<CreateAutomatedActionScreen> createState() =>
      __AutomatedActionsScreenStateState();
}

class __AutomatedActionsScreenStateState
    extends ConsumerState<CreateAutomatedActionScreen> {
  final _formKey = GlobalKey<FormState>();

  String? title;
  double? amount;
  String? action;
  String? description;
  String? day;

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
              const SizedBox(height: 120),
              Container(
                height: 62,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Title",
                    labelStyle: TextStyle(
                      color: Palette.textFieldText,
                      fontSize: 20,
                    ),
                    fillColor: Palette.textFieldBackground,
                    filled: true,
                  ),
                  onChanged: (value) => setState(() {
                    title = value;
                  }),
                ),
              ),
              const SizedBox(height: 20),
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
                  onChanged: (value) => setState(() {
                    amount = double.tryParse(value);
                  }),
                ),
              ),
              const SizedBox(height: 20),
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
                  onChanged: (value) => setState(() {
                    description = value;
                  }),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 62,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
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
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 62,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: action == 'expense'
                    ? const expenseOption()
                    : action == 'income'
                        ? const incomeOption()
                        : const nullOption(),
              ),
              const SizedBox(height: 20),
              Container(
                height: 62,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Day",
                    labelStyle: TextStyle(
                      color: Palette.textFieldText,
                      fontSize: 20,
                    ),
                    fillColor: Palette.textFieldBackground,
                    filled: true,
                  ),
                  onChanged: (value) => setState(() {
                    day = value;
                  }),
                ),
              ),
              const SizedBox(height: 20),
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
                      ref
                          .read(autoActionControllerProvider.notifier)
                          .createAutoAction(
                            context,
                            title!,
                            description!,
                            action!,
                            category!,
                            day!,
                            amount!,
                          );
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          color: Palette.buttonText,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class expenseOption extends ConsumerStatefulWidget {
  const expenseOption({super.key});

  @override
  ConsumerState<expenseOption> createState() => _expenceOptionState();
}

class _expenceOptionState extends ConsumerState<expenseOption> {
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
        items: Constants.expenseTypeDropItems,
        onChanged: (value) => category = value as String,
      ),
    );
  }
}

class incomeOption extends ConsumerStatefulWidget {
  const incomeOption({super.key});

  @override
  ConsumerState<incomeOption> createState() => _incomeOptionState();
}

class _incomeOptionState extends ConsumerState<incomeOption> {
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
        items: Constants.incomeTypeDropItems,
        onChanged: (value) => category = value as String,
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
          )),
    );
  }
}
