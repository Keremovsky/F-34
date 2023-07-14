import 'dart:io';
import 'package:bootcamp_flutter/features/automated_actions/controller/auto_action_controller.dart';
import 'package:bootcamp_flutter/features/finance/screens/finance_list_screen.dart';
import 'package:bootcamp_flutter/themes/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/constants.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  static final routeName = "/profileScreen";

  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  File? _image;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        backgroundColor: Palette.buttonBackground,
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 50,
                color: Palette.buttonBackground,
              ),
              Stack(
                children: [
                  Container(
                      width: double.infinity,
                      height: 110,
                      decoration: BoxDecoration(
                        color: Palette.buttonBackground,
                      )),
                  Center(
                    child: Container(
                      height: 220,
                      width: 220,
                      child: InkWell(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          foregroundImage:
                              _image != null ? FileImage(_image!) : null,
                          backgroundImage:
                              const AssetImage(Constants.profilePicture),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Container(
                  width: double.infinity,
                  child: RawMaterialButton(
                    fillColor: Palette.textFieldBackground,
                    elevation: 0.0,
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    onPressed: () {},
                    child: Text(
                      "Past Goals",
                      style: TextStyle(
                          color: Palette.buttonText,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Container(
                  width: double.infinity,
                  child: RawMaterialButton(
                      fillColor: Palette.textFieldBackground,
                      elevation: 0.0,
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(FinanceListScreen.routeName);
                      },
                      child: Text(
                        "Past Actions",
                        style: TextStyle(
                            color: Palette.buttonText,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Container(
                  width: double.infinity,
                  child: RawMaterialButton(
                      fillColor: Palette.textFieldBackground,
                      elevation: 0.0,
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      onPressed: () {},
                      child: Text(
                        "Automated Actions",
                        style: TextStyle(
                          color: Palette.buttonText,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
              ),
            ]),
      ),
    );
  }
}
