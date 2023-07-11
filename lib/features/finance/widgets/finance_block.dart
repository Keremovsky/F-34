import 'package:bootcamp_flutter/features/finance/controller/finance_controller.dart';
import 'package:bootcamp_flutter/features/finance/widgets/update_finance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/finance.dart';

class FinanceBlock extends ConsumerWidget {
  final Finance _finance;

  const FinanceBlock({super.key, required Finance finance})
      : _finance = finance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _finance.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Text(_finance.date),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_finance.description),
                Text(_finance.type),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _textExpenseOrIncome(_finance.value, _finance.subType),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        updateExpensePopUp(context, ref, _finance);
                      },
                      icon: const Icon(
                        Icons.update_sharp,
                        color: Colors.amber,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        ref
                            .read(financeControllerProvider.notifier)
                            .removeFinance(_finance.id, context);
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget _textExpenseOrIncome(double value, String subType) {
  String valueS = value.toString();

  if (subType == "expense") {
    return Text(
      "-$valueS",
      style: TextStyle(
        color: Colors.red.shade800,
        fontWeight: FontWeight.bold,
      ),
    );
  } else {
    return Text(
      "+$valueS",
      style: TextStyle(
        color: Colors.green.shade800,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
