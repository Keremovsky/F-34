import 'package:bootcamp_flutter/themes/palette.dart';
import 'package:flutter/material.dart';


class updateProfileScreen extends StatefulWidget {
  const updateProfileScreen({super.key});

  @override
  State<updateProfileScreen> createState() => _updateProfileScreenState();
}

class _updateProfileScreenState extends State<updateProfileScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.background,
      ),
      body: const SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

          ],
        ),
      ),
    );
  }
}