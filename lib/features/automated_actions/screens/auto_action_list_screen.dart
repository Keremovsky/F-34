import 'package:bootcamp_flutter/features/automated_actions/controller/auto_action_controller.dart';
import 'package:bootcamp_flutter/features/automated_actions/screens/auto_action_filter_screen.dart';
import 'package:bootcamp_flutter/features/automated_actions/screens/new_auto_action_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../themes/palette.dart';

class AutoActionListScreen extends ConsumerStatefulWidget {
  static const routeName = "/autoActionListScreen";

  const AutoActionListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AutoActionListScreenState();
}

class _AutoActionListScreenState extends ConsumerState<AutoActionListScreen> {
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
                          .pushNamed(AutoActionFilterScreen.routeName);
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
            child: ref
                .watch(autoActionControllerProvider.notifier)
                .getAutoActionStream(
                  context,
                  textSearch,
                  ref.watch(autoActionFilterValueProvider),
                ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Palette.buttonBackground,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(CreateAutomatedActionScreen.routeName);
                },
                child: Text(
                  "Add new automated action",
                  style: TextStyle(
                      color: Palette.buttonText,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
