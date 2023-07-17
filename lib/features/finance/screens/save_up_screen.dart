import 'package:bootcamp_flutter/features/auth/controller/auth_controller.dart';
import 'package:bootcamp_flutter/features/finance/controller/finance_controller.dart';
import 'package:flutter/material.dart';
import 'package:bootcamp_flutter/themes/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SaveUpScreen extends ConsumerStatefulWidget {
  static final routeName = "/saveUpScreen";

  const SaveUpScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SaveUpScreen> createState() => _SaveUpScreen();
}

class _SaveUpScreen extends ConsumerState<SaveUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController amountController = TextEditingController();
  bool isFail = true;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    String? amount = amountController.text;
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100.h,
              ),
              Center(
                child: Container(
                  height: 50.h,
                  width: 220.w,
                  child: Text(
                    "Save Money",
                    style: TextStyle(
                      color: Palette.titleText,
                      fontFamily: 'Inder',
                      fontSize: 40.sp,
                    ),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 80.h),
                    TextFormField(
                      controller: amountController,
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        labelStyle: TextStyle(
                          color: Palette.textFieldText,
                        ),
                        fillColor: Palette.textFieldBackground,
                        filled: true,
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 0, color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        final usermoney = ref.read(userProvider)?.money ?? 0;
                        try {
                          if (double.parse(amountController.text) > usermoney) {
                            return 'The value entered is more than the\nbalance in the wallet!';
                          }

                          isFail = false;
                          return null;
                        } catch (ex) {
                          return 'Please enter a number value';
                        } finally {
                          if ((amountController.text) == '') {
                            return 'Please enter amount';
                          }
                        }
                      },
                      onSaved: (value) => amount = value,
                    ),
                    SizedBox(height: 50.h),
                    Container(
                      width: MediaQuery.of(context).size.height.w,
                      height: 45.h,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            if (isFail == false) {
                              ref
                                  .read(financeControllerProvider.notifier)
                                  .saveMoney(context,
                                      -double.parse(amountController.text));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SuccessScreen()),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FailScreen()),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Palette.buttonBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            color: Palette.buttonText,
                            fontFamily: 'Inter',
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatefulWidget {
  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Save Up'),
      content: const SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Successful!'),
            Text('The last _____ to reach the goal.'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Okey'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class FailScreen extends StatefulWidget {
  @override
  _FailScreenState createState() => _FailScreenState();
}

class _FailScreenState extends State<FailScreen> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Save Up'),
      content: const SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Fail!'),
            Text('You do not have enough money in your wallet.'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Okey'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
