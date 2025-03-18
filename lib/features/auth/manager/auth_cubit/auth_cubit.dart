import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_visitor/core/error/firebase_failure.dart';
import 'package:my_visitor/core/utils/functions/auth_helper.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());




// انشاء حساب
  Future<void> register({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        if (!user.emailVerified) {
          await user.sendEmailVerification();
          emit(AuthSendVerification());
          log('Verification email sent. Please check your inbox.');
        }
        bool eVerified = await waitForEmailVerification(user);
        await checkEmailVerification(user);

        if (eVerified) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'email': email,
          });
          // String jsonString =
          //     jsonEncode({'email': email, 'username': userName});

          // await SharedPreference().setString(email, jsonString);

          // await FirebaseFirestore.instance.collection('users').add({
          //   "email": email,
          // });

          emit(AuthSuccess());

          log('User account created successfully.');
        } else {
          // If email verification fails, delete the user and throw an exception
          await user.delete();
          emit(AuthVerificationFailure());

          //emit(AuthFailure(errMessage: 'Email verification failed.'));
        }
      }
    } catch (e) {
      emit(AuthFailure(
          errMessage: FirebaseFailure.fromFirebaseException(e as Exception)
              .errMessage
              .toString()));
    }
  }

///////////////////////////////// تسجيل دخول
  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (!credential.user!.emailVerified) {
        emit(AuthVerificationFailure());
        return;
      }
      emit(AuthSuccess());
    } catch (e) {
      emit(
        AuthFailure(
          errMessage: FirebaseFailure.fromFirebaseException(e as Exception)
              .errMessage
              .toString(),
        ),
      );
    }
  }
//////////////

//تسجيل دخول بجوجل
  Future<UserCredential?> signInWithGoogle() async {
    emit(AuthLoading());
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Force sign out from any previous Google account
      await googleSignIn.signOut();

      // Trigger the authentication flow and prompt for account selection
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // Handle the case where the user cancels the sign-in
        emit(AuthCancel());
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      emit(AuthSuccess());
      // Once signed in, return the UserCredential
      return userCredential;
    } catch (e) {
      // Log and rethrow any other exceptions
      log('Exception: ${e.toString()}');
      emit(AuthFailure(
          errMessage: FirebaseFailure.fromFirebaseException(e as Exception)
              .errMessage
              .toString()));
    }
    return null;
  }
//////////////////////////////
  /// اعادة تعيين الباسورد

  Future<void> resetPassword(String email) async {
    emit(AuthLoading());
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(
          errMessage: FirebaseFailure.fromFirebaseException(e as Exception)
              .errMessage
              .toString()));
    }
  }
////////////////////////////////////
}
