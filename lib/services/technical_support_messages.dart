import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TechnicalSupportMessages {
  final FirebaseFirestore firestore =
      FirebaseFirestore.instance; // Firestore instance

  Future<void> technicalSupportMessage({
    required String title,
    required String content,
    required String phoneNumber,
    required BuildContext context,
  }) async {
    try {
      // Get email from shared preferences asynchronously
      //   var email = await SharedPreference().getString('email');
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        // If the user is not signed in, redirect to login page
       // GoRouter.of(context).push('/${LoginPage.id}');
        log('User is currently signed out!');
        return; // Prevent further execution
      }

      // Get the user's email
      var email = user.email;
      Map<String, dynamic> problemData = {
        'title': title,
        'content': content,
        'phoneNumber': phoneNumber,
       'email': email,
        'createdAt': FieldValue.serverTimestamp(), // Add timestamp
      };

      // Add the document to Firestore
      await firestore.collection('Technical Support').add(problemData);

      log(' send successfully');
    } catch (e) {
      log('Error sending message: $e');
    }
  }
}
