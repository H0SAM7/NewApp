import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_visitor/bottom_navv_bar.dart';
import 'package:my_visitor/constants.dart';
import 'package:my_visitor/core/styles/text_styles.dart';
import 'package:my_visitor/core/utils/shared_pref.dart';
import 'package:my_visitor/core/widgets/custom_progress_hud.dart';
import 'package:my_visitor/core/widgets/show_custom_alert.dart';
import 'package:my_visitor/features/admins/admin_account.dart';
import 'package:my_visitor/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:my_visitor/features/auth/screens/forget_view.dart';
import 'package:my_visitor/features/auth/screens/register_view.dart';
import 'package:my_visitor/features/auth/screens/widgets/custom_send_button.dart';
import 'package:my_visitor/features/auth/screens/widgets/custom_text_field.dart';
import 'package:my_visitor/features/auth/screens/widgets/google_button.dart';
import 'package:my_visitor/features/auth/screens/widgets/have_acc_widget.dart';
import 'package:my_visitor/features/auth/screens/widgets/or_widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static String id = 'LoginView';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? email, password;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, BottomNavigator.id);
          // Navigator.pushReplacementNamed(context, screenTSt.id);
        } else if (state is AuthFailure) {
          showCustomAlert(
            context: context,
            type: AlertType.error,
            title: 'Error',
            description: state.errMessage,
            onPressed: () {
              Navigator.pushReplacementNamed(context, LoginView.id);
            },
            actionTitle: 'Ok',
          );
        }
      },
      builder: (context, state) {
        return CustomProgressHUD(
          inAsyncCall: state is AuthLoading,
          child: AbsorbPointer(
            absorbing: state is AuthLoading,
            child: Scaffold(
              backgroundColor: Colors.white,
              body:
                  // size: MediaQuery.of(context).size,

                  Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * .20,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: CustomBack(),
                      // ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Welcome back! \nGlad to see you, Again!',
                          style: AppStyles.style22White(context)
                              .copyWith(fontSize: 25),
                        ),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      CustomTextFrom(
                        hint: 'Enter Your Email',
                        label: 'Email',
                        prefixIcon: Icon(Icons.lock),
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                      CustomTextFrom(
                        hint: "enter  your password",
                        label: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        isPasswordField: true,
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, ForgetView.id);
                          },
                          child: Text(
                            'Forget Password',
                            style: TextStyle(color: redColor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: CustomSendButton(
                          label: 'Login',
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              await BlocProvider.of<AuthCubit>(context)
                                  .login(email: email!, password: password!);
                              if (email == AdminAccount.email &&
                                  password == AdminAccount.pass) {
                                log('Admin Mode');
                                SharedPreference().setBool('admin', true);
                              }
                          
                              var admin = await SharedPreference().getBool(
                                'admin',
                              );
                              log(admin.toString());
                              await FirebaseMessaging.instance
                                  .subscribeToTopic(notifiGroup);
                            }

                            //  FirebaseAuth.instance.authStateChanges().listen((User? user) {
                            //                   if (user == null) {
                            //                     Navigator.pushNamed(context, RegisterView.id);
                            //                     log('User is currently signed out!');
                            //                   } else {
                            //                     if (user.emailVerified) {
                            //                       Navigator.pushReplacementNamed(context, BottomNavigator.id);
                            //                       log('User is signed in!');
                            //                     } else if (!user.emailVerified) {
                            //                       // Navigator.pushReplacementNamed(
                            //                       //     context, VerificationView.id);
                            //                     } else {
                            //                       Navigator.pushReplacementNamed(context, RegisterView.id);
                            //                     }
                            //                   }
                            //                 });
                          },
                        ),
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                      const Center(child: OrWidget()),

                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: GoogleButton(
                          onTap: () async {
                            await BlocProvider.of<AuthCubit>(context)
                                .signInWithGoogle();
                            await FirebaseMessaging.instance
                                .subscribeToTopic(notifiGroup);
                          },
                        ),
                      ),

                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HaveAccWidget(
                            title: 'Don’t have an account? ',
                            action: 'Sign Up',
                            onPressed: () {
                              Navigator.pushNamed(context, RegisterView.id);
                            },
                          ),
                        ],
                      ),
                      //   const SocialAuth(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
