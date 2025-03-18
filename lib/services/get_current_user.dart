import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_visitor/features/home/data/home_repo/home_repo.dart';

Future<String?> getCurrentUserEmailFromFirestore() async {
  try {
    // Get the current logged-in user
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // Fetch the user's data from Firestore using their UID
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(currentUser.uid).get();

      if (userDoc.exists) {
        // Extract the email from the document
        String email = userDoc.get('email');
        String username = userDoc.get('username');
        // await SharedPreference().setString('currentEmail', email);
        // await SharedPreference().setString('currentUsername', username);
        log('Current user email: $email');

        return email;
      } else {
        log('User data not found in Firestore.');
      }
    } else {
      return null;
    }
  } catch (e) {
    log('Error retrieving user email: $e');
  }
  return null;
}
