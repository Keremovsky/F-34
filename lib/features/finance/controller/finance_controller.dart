import 'package:bootcamp_flutter/features/finance/repository/finance_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  void addFinance(String description, String type, String subType, double value,
      BuildContext context) async {
    final control =
        await _financeRepository.addFinance(description, type, subType, value);

    if (control) {
      if (mounted) {
        _giveFeedback("Success", context);
        Future.delayed(const Duration(seconds: 1));
        Navigator.of(context).pop();
      }
    } else {
      if (mounted) {
        _giveFeedback("Failure", context);
      }
    }
  }

  void removeFinance(String id, BuildContext context) async {
    final control = await _financeRepository.removeFinance(id);

    if (control) {
      if (mounted) {
        _giveFeedback("Success", context);
        Future.delayed(const Duration(seconds: 1));
        Navigator.of(context).pop();
      }
    } else {
      if (mounted) {
        _giveFeedback("Failure", context);
      }
    }
  }

  void updateFinance(Finance finance, String? title, String? type,
      double? value, BuildContext context) async {
    final control =
        await _financeRepository.updateFinance(finance, title, type, value);

    if (control) {
      if (mounted) {
        _giveFeedback("Success", context);
        Future.delayed(const Duration(seconds: 1));
        Navigator.of(context).pop();
      }
    } else {
      if (mounted) {
        _giveFeedback("Failure", context);
      }
    }
  }

  Widget getFinanceStream(
      BuildContext context, String searchText, String subType) {
    final result = _financeRepository.getFinanceStream();

    return StreamBuilder(
      stream: result,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // get all finances from database
          List<Finance> finances = snapshot.data!.docs
              .map((e) => Finance.fromMap(e.data() as Map<String, dynamic>))
              .toList();

          // filter with given text
          finances = finances.where((finance) {
            final actual = finance.description.toLowerCase();
            final input = searchText.toLowerCase();

            return actual.contains(input);
          }).toList();

          // filter with given text
          finances = finances.where((finance) {
            final actual = finance.subType;

            return actual.contains(subType);
          }).toList();

          return ListView.builder(
            itemCount: finances.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Text(finances[index].description),
                  const SizedBox(height: 20),
                ],
              );
            },
          );
        } else {
          return const SizedBox(
            height: 100,
            width: 100,
            child: Text("No Finance Data :("),
          );
        }
      },
    );
  }
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _giveFeedback(
    String feedback, BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(feedback),
    ),
  );
}
