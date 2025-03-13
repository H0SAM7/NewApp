import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_visitor/core/styles/text_styles.dart';
import 'package:my_visitor/core/widgets/custom_back.dart';
import 'package:my_visitor/core/widgets/custom_progress_hud.dart';
import 'package:my_visitor/core/widgets/show_custom_alert.dart';
import 'package:my_visitor/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:my_visitor/features/auth/views/login_view.dart';
import 'package:my_visitor/features/auth/views/widgets/custom_send_button.dart';
import 'package:my_visitor/features/auth/views/widgets/custom_text_field.dart';
import 'package:my_visitor/features/auth/views/widgets/google_button.dart';
import 'package:my_visitor/features/auth/views/widgets/have_acc_widget.dart';
import 'package:my_visitor/features/auth/views/widgets/or_widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  static String id = 'RegisterView';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email, password, phone, fatherPhone, name;
  bool _isDialogShowing = false; // Prevent multiple alerts

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, LoginView.id);
        } else if (state is AuthSendVerification) {
          showCustomAlert(
            context: context,
            type: AlertType.info,
            title: 'Check  your email',
            description:
                'Please  check your email to verify your account, and you can Login ',
            onPressed: () {
              Navigator.pushNamed(context, LoginView.id);
            },
            actionTitle: 'Ok',
          );
        } else if (state is AuthVerificationFailure) {
          showCustomAlert(
            context: context,
            type: AlertType.warning,
            title: 'Time out',
            description: state.errMessage,
            onPressed: () {
              Navigator.pushReplacementNamed(context, RegisterView.id);
            },
            actionTitle: 'Ok',
          );
        } else if (state is AuthFailure) {
          if (!_isDialogShowing) {
            _isDialogShowing = true; // Set flag to true before showing dialog

            showCustomAlert(
              context: context,
              type: AlertType.error,
              title: 'Error',
              description: state.errMessage,
              onPressed: () {
                          _isDialogShowing = false; // Reset flag after dismissing

                Navigator.pop(context);
              },
              actionTitle: 'Ok',
            );
          }
        }
      },
      builder: (context, state) {
        return CustomProgressHUD(
          inAsyncCall: state is AuthLoading,
          child: AbsorbPointer(
            absorbing: state is AuthLoading,
            child: Scaffold(
              backgroundColor: Colors.black,
              body: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomBack(),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Hello! Register to get \nstarted',
                          style: AppStyles.style22White(context)
                              .copyWith(fontSize: 25),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextFrom(
                        hint: 'enter name',
                        label: 'Name',
                        onChanged: (value) {
                          name = value;
                        },
                      ),
                      CustomTextFrom(
                        hint: 'enter email',
                        label: 'Email',
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                      CustomTextFrom(
                        hint: 'enter password',
                        label: 'Password',
                        isPasswordField: true,
                        onChanged: (value) {
                          password = value;
                        },
                      ),

                      HaveAccWidget(
                        title: 'You have Accounts? ',
                        action: 'Login',
                        onPressed: () {
                          Navigator.pushNamed(context, LoginView.id);
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: CustomSendButton(
                          label: 'Sign Up',
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              await BlocProvider.of<AuthCubit>(context)
                                  .register(
                                email: email!,
                                password: password!,
                              );

                              // await FirebaseMessaging.instance
                              //     .subscribeToTopic(notifiGroup);
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Center(child: OrWidget()),
                      const SizedBox(
                        height: 10,
                      ),
                      // const SocialAuth(),
                      Center(
                        child: GoogleButton(
                          onTap: () async {
                            await BlocProvider.of<AuthCubit>(context)
                                .signInWithGoogle();
                            // await FirebaseMessaging.instance
                            //     .subscribeToTopic(notifiGroup);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
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
