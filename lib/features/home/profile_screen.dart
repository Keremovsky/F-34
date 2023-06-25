import 'dart:io';

import 'package:bootcamp_flutter/themes/palette.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;

  Future<void> _uploadImage() async {
    if (_image != null) {
      try {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference reference =
            storage.ref().child('profile_pictures/${DateTime.now()}.png');
        UploadTask uploadTask = reference.putFile(_image!);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        print('Profile picture uploaded: $downloadUrl');
      } on FirebaseException catch (e) {
        print('Error uploading profile picture: $e');
      }
    } else {
      print('No image selected');
    }
  }

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
              children: [Container(
                width: double.infinity,
                height: 110,
                decoration: BoxDecoration(
                  color: Palette.buttonBackground,
                    )
                ),
            Center(
                child: Container(
                  height: 220,
                  width: 220,
                  child: InkWell(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      backgroundImage: _image != null ? FileImage(_image!) : null,
                    ),
                  ),
                ),
              ),
            ],),
            SizedBox(height: 80,),
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
                  onPressed: () {  },
                  child: Text(
                    "Past Goals",
                    style: TextStyle(
                      color: Palette.buttonText,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                      ),
                    )
                ),
              ),
            ),
            SizedBox(height: 35,),
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
                  onPressed: () {  },
                  child: Text(
                    "Past Actions",
                    style: TextStyle(
                      color: Palette.buttonText,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                      ),
                    )
                ),
              ),
            ),
            SizedBox(height: 35,),
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
                  onPressed: () {  },
                  child: Text(
                    "Automated Actions",
                    style: TextStyle(
                      color: Palette.buttonText,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}


