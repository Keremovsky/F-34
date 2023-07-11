import 'package:bootcamp_flutter/features/finance/repository/finance_repository.dart';
import 'package:bootcamp_flutter/features/finance/widgets/finance_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import '../../../models/finance.dart';

final financeControllerProvider = StateNotifierProvider(
  (ref) => FinanceController(
    financeRepository: ref.read(financeRepositoryProvider),
  ),
);

class FinanceController extends StateNotifier {
  final FinanceRepository _financeRepository;

  FinanceController({required financeRepository})
      : _financeRepository = financeRepository,
        super(false);

  void addFinance(String title, String description, String type, String subType,
      double value, BuildContext context) async {
    final control = await _financeRepository.addFinance(
        title, description, type, subType, value);

    if (control) {
      if (mounted) {
        _giveFeedback("Success", context);
        Future.delayed(const Duration(seconds: 1))
            .then((value) => Navigator.of(context).pop());
      }
    } else {
      if (mounted) {
        _giveFeedback("Failure", context);
      }
    }
  }

  void removeFinance(String id, BuildContext context) async {
    final control = await _financeRepository.removeFinance(id);
  }

  void updateFinance(Finance finance, String? title, String? type,
      double? value, BuildContext context) async {
    final control =
        await _financeRepository.updateFinance(finance, title, type, value);

    if (control) {
      if (mounted) {
        _giveFeedback("Success", context);
        Future.delayed(const Duration(seconds: 1))
            .then((value) => Navigator.of(context).pop());
      }
    } else {
      if (mounted) {
        _giveFeedback("Failure", context);
      }
    }
  }

  Widget getFinanceStream(
      BuildContext context, String searchText, Map<String, dynamic> filter) {
    final result = _financeRepository.getFinanceStream();

    return StreamBuilder(
      stream: result,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // get all finances from database
          List<Finance> finances = snapshot.data!.docs
              .map((e) => Finance.fromMap(e.data() as Map<String, dynamic>))
              .toList();

          if (finances.isEmpty) {
            return const SizedBox(
              height: 200,
              width: 200,
              child: Text("No Finance Data :("),
            );
          }

          // filtering finances
          finances = finances.where((finance) {
            return _filterFinance(finance, searchText, filter);
          }).toList();

          return ListView.builder(
            itemCount: finances.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  FinanceBlock(finance: finances[index]),
                  const SizedBox(height: 20),
                  const Divider(height: 5),
                ],
              );
            },
          );
        } else {
          return Container(
            height: 200,
            width: 200,
            child: const CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

// return a feedback Snackbar
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _giveFeedback(
    String feedback, BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(feedback),
    ),
  );
}

// return true if all filtering inputs are correct
bool _filterFinance(
    Finance finance, String searchText, Map<String, dynamic> filter) {
  final financeTitle = finance.title.toLowerCase();

  return financeTitle.contains(searchText.toLowerCase()) &&
      finance.type.contains(filter["type"]) &&
      finance.subType.contains(filter["subType"]) &&
      finance.date.contains(filter["date"]) &&
      filter["minValue"] < finance.value &&
      filter["maxValue"] > finance.value;
}
