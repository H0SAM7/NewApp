import 'package:my_visitor/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:my_visitor/features/auth/views/widgets/custom_text_field.dart';

class CreateNewPass extends StatelessWidget {
  const CreateNewPass({super.key});
  static String id = 'CreateNewPass';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // const CustomBack(
            //   title: 'Create a New Password',
            // ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                'Enter a strong and secure password to protect your account.',
                style: AppStyles.style18(context),
              ),
            ),
              const SizedBox(
              height: 20,
            ),
          CustomTextFrom(
            label: 'Password',
            hint: 'Enter your Password',
            isPasswordField: true,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                  'Password must include at least 8 characters, an uppercase letter, a number, and a special character',
                  style: AppStyles.style18(context),
                ),
          ),
               const SizedBox(
              height: 10,
            ),
          CustomTextFrom(
            label: 'Confirm Password',
            hint: 'Re-Enter your Password',
            isPasswordField: true,
          ),
           
              const SizedBox(
              height: 30,
            ),
           // CustomButton(title: 'Reset Password',onTap: (){},)
          ],
        ),
      ),
    );
  }
}
