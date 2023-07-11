import 'package:bootcamp_flutter/core/constants/constants.dart';
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
  final TextEditingController descriptionController = TextEditingController();
  late int money = 100;
  bool isFail = true;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    String? amount = amountController.text;
    String? description = descriptionController.text;
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: null,
      body: Padding(
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
                          try {
                            if (int.parse(amountController.text) > money) {
                              return 'The value entered is more than the\nbalance in the wallet!';
                            }
                            isFail = false;
                            return null;
                          } catch (ex) {
                            return 'Please enter a number value';
                          } finally {
                            RequiredValidator(
                                errorText: 'Please enter amount!');
                          }
                        },
                        onSaved: (value) => amount = value,
                      ),
                      SizedBox(height: 50.h),
                      TextFormField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description',
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
                        onSaved: (value) => description = value,
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SuccessScreen()),
                                );
                                money = money - int.parse(amountController.text);
                              }
                              else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => FailScreen()),
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