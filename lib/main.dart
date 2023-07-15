import 'package:bootcamp_flutter/features/auth/screens/login_screen.dart';
import 'package:bootcamp_flutter/features/automated_actions/screens/auto_action_filter_screen.dart';
import 'package:bootcamp_flutter/features/automated_actions/screens/auto_action_list_screen.dart';
import 'package:bootcamp_flutter/features/automated_actions/screens/new_auto_action_screen.dart';
import 'package:bootcamp_flutter/features/finance/screens/exchange_screen.dart';
import 'package:bootcamp_flutter/features/finance/screens/finance_filter_screen.dart';
import 'package:bootcamp_flutter/features/finance/screens/finance_list_screen.dart';
import 'package:bootcamp_flutter/features/finance/screens/save_up_screen.dart';
import 'package:bootcamp_flutter/features/user_profile/screens/profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/auth/screens/forgot_screen.dart';
import 'features/auth/screens/sign_up_screen.dart';
import 'features/finance/screens/expense_screen.dart';
import 'features/finance/screens/income_screen.dart';
import 'features/home/home_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bootcamp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade800),
        useMaterial3: true,
      ),
      routes: {
        "/": (context) => const LoginScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        ForgotScreen.routeName: (context) => const ForgotScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
        IncomeScreen.routeName: (context) => IncomeScreen(),
        ExpenseScreen.routeName: (context) => ExpenseScreen(),
        FinanceListScreen.routeName: (context) => const FinanceListScreen(),
        FinanceFilterScreen.routeName: (context) => const FinanceFilterScreen(),
        SaveUpScreen.routeName: (context) => const SaveUpScreen(),
        ExchangeScreen.routeName: (context) => const ExchangeScreen(),
        AutoActionListScreen.routeName: (context) => AutoActionListScreen(),
        CreateAutomatedActionScreen.routeName: (context) =>
            const CreateAutomatedActionScreen(),
        AutoActionFilterScreen.routeName: (context) => AutoActionFilterScreen(),
      },
    );
  }
}
