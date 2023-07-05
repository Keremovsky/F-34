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
      }
    } else {
      if (mounted) {
        _giveFeedback("Failure", context);
      }
    }
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
