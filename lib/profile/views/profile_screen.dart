
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_visitor/core/utils/assets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const String id='ProfileScreen';

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Box profileBox = Hive.box('profileBox');
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  String? imagePath;

  @override
  void initState() {
    super.initState();
    nameController.text = profileBox.get('name', defaultValue: 'John Doe');
    emailController.text =
        profileBox.get('email', defaultValue: 'john.doe@example.com');
    bioController.text =
        profileBox.get('bio', defaultValue: 'Flutter Developer');
    imagePath = profileBox.get('imagePath');
  }

  void saveProfile() {
    profileBox.put('name', nameController.text);
    profileBox.put('email', emailController.text);
    profileBox.put('bio', bioController.text);
    if (imagePath != null) {
      profileBox.put('imagePath', imagePath);
    }
    setState(() {});
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
      profileBox.put('imagePath', imagePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: imagePath != null
                    ? FileImage(File(imagePath!))
                    : AssetImage(Assets.imagesAvatar) as ImageProvider,
              ),
            ),
            SizedBox(height: 20),
            TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name')),
            TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email')),
            // TextField(
            //     controller: bioController,
            //     decoration: InputDecoration(labelText: 'Bio')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: saveProfile, child: Text('Save')),
          ],
        ),
      ),
    );
  }
}
