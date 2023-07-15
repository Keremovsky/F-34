import 'package:bootcamp_flutter/features/finance/controller/finance_controller.dart';
import 'package:bootcamp_flutter/features/finance/screens/finance_filter_screen.dart';
import 'package:bootcamp_flutter/themes/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinanceListScreen extends ConsumerStatefulWidget {
  static const routeName = "/financeListScreen";

  const FinanceListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FinanceListScreenState();
}

class _FinanceListScreenState extends ConsumerState<FinanceListScreen> {
  String textSearch = "";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Palette.background,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 40.0),
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.6,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Search with title',
                      fillColor: Palette.textFieldBackground,
                      filled: true,
                    ),
                    onChanged: (value) {
                      setState(() {
                        textSearch = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: width * 0.05),
                SizedBox(
                  height: 55,
                  width: 110,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(FinanceFilterScreen.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text("Filter"),
                  ),
                ),
              ],
            ),
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
