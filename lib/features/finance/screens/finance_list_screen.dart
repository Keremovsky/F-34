import 'package:bootcamp_flutter/features/finance/controller/finance_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinanceListScreen extends ConsumerStatefulWidget {
  static final routeName = "/financeListScreen";

  const FinanceListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FinanceListScreenState();
}

class _FinanceListScreenState extends ConsumerState<FinanceListScreen> {
  final textController = TextEditingController();
  String textSearch = "";
  String subType = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          const Text("PAST ACTIONS"),
          const SizedBox(height: 50),
          DropdownButton(
            items: const [
              DropdownMenuItem(
                value: "expense",
                child: Text("Expense"),
              ),
              DropdownMenuItem(
                value: "income",
                child: Text("Income"),
              ),
            ],
            onChanged: (value) {
              setState(() {
                subType = value!;
              });
            },
          ),
          const SizedBox(height: 50),
          TextField(
            controller: textController,
            onChanged: (value) {
              setState(() {
                textSearch = value;
              });
            },
          ),
          Expanded(
            child: ref
                .watch(financeControllerProvider.notifier)
                .getFinanceStream(context, textSearch, subType),
          ),
        ],
      ),
    );
  }
}
