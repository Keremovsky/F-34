import 'package:bootcamp_flutter/features/finance/controller/finance_controller.dart';
import 'package:bootcamp_flutter/features/finance/screens/finance_filter_screen.dart';
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
  String textSearch = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: FinanceFilterScreen(),
      body: Column(
        children: [
          const SizedBox(height: 50),
          const Text("PAST ACTIONS"),
          const SizedBox(height: 50),
          TextField(
            onChanged: (value) {
              setState(() {
                textSearch = value;
              });
            },
          ),
          Expanded(
            child:
                ref.watch(financeControllerProvider.notifier).getFinanceStream(
                      context,
                      textSearch,
                      ref.watch(filterValueProvider),
                    ),
          ),
        ],
      ),
    );
  }
}
