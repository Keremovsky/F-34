import 'package:bootcamp_flutter/features/finance/controller/finance_controller.dart';
import 'package:bootcamp_flutter/models/finance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future updateExpensePopUp(
    BuildContext context, WidgetRef ref, Finance finance) {
  late String _title, _description;
  late double _value;

  final _key = GlobalKey<FormState>();

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        scrollable: true,
        content: Stack(
          children: [
            Form(
              key: _key,
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (value) => _title = value!,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "It is Empty";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: "Title"),
                    initialValue: finance.title,
                  ),
                  TextFormField(
                    onSaved: (value) => _description = value!,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "It is Empty";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: "Description"),
                    initialValue: finance.description,
                  ),
                  TextFormField(
                    onSaved: (value) => _value = double.parse(value!),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "It is Empty";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: "Value"),
                    initialValue: finance.value.toString(),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        _key.currentState!.save();
                        ref
                            .read(financeControllerProvider.notifier)
                            .updateFinance(
                                finance, _title, _description, _value, context);
                      }
                    },
                    child: const Text("Update Finance"),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
