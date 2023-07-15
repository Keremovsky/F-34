import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../../core/constants/constants.dart';
import '../../../themes/palette.dart';

final autoActionFilterValueProvider =
    StateProvider<Map<String, dynamic>>((ref) => <String, dynamic>{
          "type": "",
          "subType": "",
          "minValue": 0,
          "maxValue": double.maxFinite,
        });

class AutoActionFilterScreen extends ConsumerStatefulWidget {
  static const routeName = "/autoActionFilterScreen";

  const AutoActionFilterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FinanceFilterScreenState();
}

class _FinanceFilterScreenState extends ConsumerState<AutoActionFilterScreen> {
  // filter elements
  String? _type, _subType;
  double? _minValue, _maxValue;

  // type item list
  List<DropdownMenuItem> _currentItems =
      Constants.expenseTypeDropItems + Constants.incomeTypeDropItems;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Palette.background,
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.05,
                right: width * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * 0.4,
                    child: TextFormField(
                      onChanged: (value) => _minValue = double.tryParse(value),
                      decoration: const InputDecoration(
                        hintText: "min value",
                        filled: true,
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                          RegExp(r'(^\d*\.?\d*)'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width * 0.4,
                    child: TextFormField(
                      onChanged: (value) => _maxValue = double.tryParse(value),
                      decoration: const InputDecoration(
                        hintText: "max value",
                        filled: true,
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                          RegExp(r'(^\d*\.?\d*)'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _customSizedBox(),
            //dropdown button for subtype
            SizedBox(
              width: width * 0.9,
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Automated Action Type',
                  fillColor: Palette.textFieldBackground,
                  filled: true,
                ),
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
                onChanged: (value) => setState(() {
                  _subType = value;

                  if (_subType == "income") {
                    _currentItems = Constants.incomeTypeDropItems;
                  } else if (_subType == "expense") {
                    _currentItems = Constants.expenseTypeDropItems;
                  } else {
                    _currentItems = Constants.expenseTypeDropItems +
                        Constants.incomeTypeDropItems;
                  }
                }),
              ),
            ),
            _customSizedBox(),
            // dropdown button for type
            SizedBox(
              width: width * 0.9,
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Type',
                  fillColor: Palette.textFieldBackground,
                  filled: true,
                ),
                items: _currentItems,
                onChanged: (value) => _type = value,
              ),
            ),
            const SizedBox(height: 50),
            // button to apply filters
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Palette.buttonBackground),
                fixedSize:
                    MaterialStatePropertyAll(Size.fromWidth(width * 0.9)),
              ),
              onPressed: () {
                ref
                    .read(autoActionFilterValueProvider.notifier)
                    .update((state) => <String, dynamic>{
                          "type": _type ?? "",
                          "subType": _subType ?? "",
                          "minValue": _minValue ?? 0,
                          "maxValue": _maxValue ?? double.maxFinite,
                        });
                debugPrint(ref.read(autoActionFilterValueProvider).toString());
                Future.delayed(const Duration(milliseconds: 400))
                    .then((value) => Navigator.of(context).pop());
              },
              child: Text(
                "Filter",
                style: TextStyle(color: Palette.buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

SizedBox _customSizedBox() {
  return const SizedBox(height: 30);
}
