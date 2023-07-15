import 'package:bootcamp_flutter/features/automated_actions/controller/auto_action_controller.dart';
import 'package:bootcamp_flutter/models/auto_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AutoActionBlock extends ConsumerWidget {
  final AutoAction _autoAction;

  const AutoActionBlock({super.key, required AutoAction autoAction})
      : _autoAction = autoAction;

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
                  _autoAction.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_autoAction.description),
                Text(_autoAction.type),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _textExpenseOrIncome(_autoAction.value, _autoAction.subType),
                IconButton(
                  onPressed: () {
                    ref
                        .read(autoActionControllerProvider.notifier)
                        .removeAutoAction(context, _autoAction.id);
                  },
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
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
