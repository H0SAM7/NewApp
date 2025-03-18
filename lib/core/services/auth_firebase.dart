import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthHelper {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  // Future<void> registerUser(
  //     String email, String password, String username) async {
  //   // Create a new user
  //   UserCredential userCredential = await auth.createUserWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );
  //   User? user = userCredential.user;

  //   if (user != null) {
  //     // Send verification email
  //     if (!user.emailVerified) {
  //       await user.sendEmailVerification();
  //       log('Verification email sent. Please check your inbox.');

  //       // Prompt user to verify email
  //       // (Optional) Show a dialog or notification prompting the user to check their email
  //     }
  //     bool emailVerified = await _waitForEmailVerification(user);
  //     // Wait until the user verifies their email
  //     await _checkEmailVerification(user);

  //     if (emailVerified) {
  //       // Create user account in Firestore or other actions
  //       await firestore.collection('users').doc(user.uid).set({
  //         'uid': user.uid,
  //         'email': email,
  //         'username': username,
  //         // Add other fields as needed
  //       });
  //       log('User account created successfully.');
  //     } else {
  //       log('Email verification failed. Please verify your email.');
  //     }
  //   }

  //   // on FirebaseAuthException catch (e) {
  //   //   if (e.code == 'email-already-in-use') {
  //   //     log('The email address is already in use by another account.');
  //   //   } else if (e.code == 'invalid-email') {
  //   //     log('The email address is not valid.');
  //   //   } else if (e.code == 'weak-password') {
  //   //     log('The password is too weak.');
  //   //   } else {
  //   //     log('Registration error: ${e.message}');
  //   //   }
  //   // } on FirebaseException catch (e) {
  //   //   log('Firebase error: ${e.message}');
  //   // } catch (e) {
  //   //   log('Unexpected error: $e');
  //   // }
  // }

  // Future<void> _checkEmailVerification(User user) async {
  //   while (!user.emailVerified) {
  //     const SizedBox(
  //       height: 50,
  //       width: 50,
  //       child: Column(
  //         children: [
  //           CircularProgressIndicator(),
  //           Text('Verification email sent. Please check your inbox.')
  //         ],
  //       ),
  //     );
  //     await Future.delayed(const Duration(seconds: 5));
  //     await user.reload();

  //     user = auth.currentUser!;
  //   }
  // }
  // await firestore.collection('users').doc(user.uid).set({

  //       'uid': user.uid,
  //           'email': email,
  //           'username': username,
  //           // Add other fields as needed
  //         });




  // Future<void> deleteUser() async {
  //   try {
  //     if (user != null) {
  //       await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(user!.uid)
  //           .delete();
  //       log("Document with UID ${user!.uid} deleted successfully");
  //       await user!.delete();
  //       // Account deletion successful
  //       log("Account deleted successfully.");
  //     }
  //   } catch (e) {
  //     // Handle errors here, like reauthentication requirements
  //     log("Error deleting account: $e");
  //   }
  // }

  // Future<void> logout() async {
  //   try {
  //     await auth.signOut();
  //     log("User logged out successfully.");
  //   } catch (e) {
  //     log("Error logging out: $e");
  //   }
  // }

  // Future<bool> _waitForEmailVerification(User user) async {
  //   const timeout = Duration(minutes: 5);
  //   const interval = Duration(seconds: 5);
  //   final endTime = DateTime.now().add(timeout);

  //   while (DateTime.now().isBefore(endTime)) {
  //     await Future.delayed(interval);
  //     await user.reload();
  //     user = auth.currentUser!;

  //     if (user.emailVerified) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  // Future<void> loginUser(String email, String password) async {
  //   await FirebaseAuth.instance
  //       .signInWithEmailAndPassword(email: email, password: password);
  //   log('The Login Successful');
  // }

  // Future<void> updateUser(
  //     String oldPassword, String newPassword, String username) async {
  //   try {
  //     User? user = auth.currentUser;

  //     if (user != null) {
  //       String email = user.email!;

  //       // Re-authenticate the user
  //       AuthCredential credential = EmailAuthProvider.credential(
  //         email: email,
  //         password: oldPassword,
  //       );
  //       await user.reauthenticateWithCredential(credential);
  //       log('Re-authentication successful.');
  //       await user.updatePassword(newPassword);

  //       // Update user account in Firestore or other actions
  //       await firestore.collection('users').doc(user.uid).update({
  //         'uid': user.uid,
  //         'username': username,
  //         // Add other fields as needed
  //       });
  //       log('User account updated successfully.');
  //     }
  //   } catch (e) {
  //     log('Error updating user: $e');
  //     // Handle errors, e.g., show a message to the user
  //   }
  // }

  // Future<dynamic> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //     final GoogleSignInAuthentication? googleAuth =
  //         await googleUser?.authentication;

  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );

  //     return await FirebaseAuth.instance.signInWithCredential(credential);
  //   }  catch (e) {
     
  //     log('exception->$e');
  //   }
  // }

  // Future<bool> signOutFromGoogle() async {
  //   try {
  //     await FirebaseAuth.instance.signOut();
  //     return true;
  //   } on Exception catch (_) {
  //     return false;
  //   }
  // }

  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Function to upload profile photo
  Future<String?> uploadProfilePhoto(String userId) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File file = File(pickedFile.path);
      Reference ref =
          _storage.ref().child('profile_photos').child('$userId.jpg');

      try {
        UploadTask uploadTask = ref.putFile(file);
        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
          // Optionally handle progress updates here
          double progress = snapshot.bytesTransferred / snapshot.totalBytes;
          log('Upload progress: ${progress * 100}%');
        });

        await uploadTask;
        String downloadUrl = await ref.getDownloadURL();
        return downloadUrl;
      } on FirebaseException catch (e) {
        log('Firebase error uploading profile photo: ${e.message}');
        return null;
      } catch (e) {
        log('Error uploading profile photo: $e');
        return null;
      }
    }
    return null;
  }

  // Function to get profile photo URL
  Future<String?> getProfilePhotoUrl(String userId) async {
    try {
      Reference ref =
          _storage.ref().child('profile_photos').child('$userId.jpg');
      String downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      log('Firebase error fetching profile photo URL: ${e.message}');
      return null;
    } catch (e) {
      log('Error fetching profile photo URL: $e');
      return null;
    }
  }

  // Function to update user profile with photo URL
  Future<void> updateUserProfilePhoto(String userId, String downloadUrl) async {
    try {
      await firestore.collection('users').doc(userId).update({
        'profilePhotoUrl': downloadUrl,
      });
    } on FirebaseException catch (e) {
      log('Firebase error updating user profile: ${e.message}');
    } catch (e) {
      log('Error updating user profile: $e');
    }
  }
}
























// final FirebaseStorage storage = FirebaseStorage.instance;




//   // Function to upload profile photo
//   Future<String?> uploadProfilePhoto(String userId) async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       File file = File(pickedFile.path);
//       Reference ref = storage.ref().child('profile_photos').child('$userId.jpg');

//       try {
//         await ref.putFile(file);
//         String downloadUrl = await ref.getDownloadURL();
//         return downloadUrl;
//       } catch (e) {
//         print('Error uploading profile photo: $e');
//         return null;
//       }
//     }
//     return null;
//   }

//   Future<String?> getProfilePhotoUrl(String userId) async {
//     try {
//       Reference ref = storage.ref().child('profile_photos').child('$userId.jpg');
//       String downloadUrl = await ref.getDownloadURL();
//       return downloadUrl;
//     } catch (e) {
//       print('Error fetching profile photo URL: $e');
//       return null;
//     }
//   }

//   // Function to update user profile with photo URL
//   Future<void> updateUserProfilePhoto(String userId, String downloadUrl) async {
//     try {
//       await firestore.collection('users').doc(userId).update({
//         'profilePhotoUrl': downloadUrl,
//       });
//     } catch (e) {
//       print('Error updating user profile: $e');
//     }
//   }




