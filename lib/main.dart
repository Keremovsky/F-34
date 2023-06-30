import 'package:bootcamp_flutter/features/auth/screens/login_screen.dart';
import 'package:bootcamp_flutter/features/expense/screens/expense_screen.dart.dart';
import 'package:bootcamp_flutter/features/home/profile_screen.dart';
import 'package:bootcamp_flutter/features/income/screens/income_screen.dart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/auth/screens/forgot_screen.dart';
import 'features/auth/screens/sign_up_screen.dart';
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
        "/": (context) => ProfileScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        ForgotScreen.routeName: (context) => ForgotScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        ProfileScreen.routeName: (context) => ProfileScreen(),
        IncomeScreen.routeName: (context) => IncomeScreen(),
        ExpenseScreen.routeName: (context) => ExpenseScreen(),
      },
    );
  }
}
