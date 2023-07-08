import 'package:bootcamp_flutter/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../themes/palette.dart';

final filterValueProvider =
    StateProvider<Map<String, dynamic>>((ref) => <String, dynamic>{
          "type": "",
          "subType": "",
          "date": "",
          "minValue": 0,
          "maxValue": double.maxFinite,
        });

class FinanceFilterScreen extends ConsumerStatefulWidget {
  static final routeName = "/financeFilterScreen";

  const FinanceFilterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FinanceFilterScreenState();
}

class _FinanceFilterScreenState extends ConsumerState<FinanceFilterScreen> {
  String? type, subType, date;
  double? minValue, maxValue;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Drawer(
      child: Form(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.005,
                right: width * 0.005,
                top: width * 0.1,
              ),
              child: Row(
                children: [
                  Container(
                    width: width * 0.4,
                    child: TextFormField(
                      onChanged: (value) => minValue = double.parse(value),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: width * 0.4,
                    child: TextFormField(
                      onChanged: (value) => maxValue = double.parse(value),
                    ),
                  ),
                ],
              ),
            ),
            // dropdown button for type
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Type',
                fillColor: Palette.textFieldBackground,
                filled: true,
              ),
              items: Constants.expenseTypeDropItems +
                  Constants.incomeTypeDropItems,
              onChanged: (value) => type = value,
            ),
            //dropdown button for subtype
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Finance Type',
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
              onChanged: (value) => subType = value,
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(filterValueProvider.notifier)
                    .update((state) => <String, dynamic>{
                          "type": type ?? "",
                          "subType": subType ?? "",
                          "date": date ?? "",
                          "minValue": minValue ?? 0,
                          "maxValue": maxValue ?? double.maxFinite,
                        });

                print(ref.read(filterValueProvider));
              },
              child: const Text("Filter"),
            ),
          ],
        ),
      ),
    );
  }
}
