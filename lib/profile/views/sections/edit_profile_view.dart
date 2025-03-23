import 'package:flutter/material.dart';
import 'package:my_visitor/core/styles/text_styles.dart';
import 'package:my_visitor/core/utils/assets.dart';
import 'package:my_visitor/features/auth/screens/widgets/custom_send_button.dart';
import 'package:my_visitor/features/auth/screens/widgets/custom_text_field.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});
  static String id = 'EditProfileView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomAppBar(title: 'Edit Profile'),
              CircleAvatar(
                radius: 45,
                backgroundColor: Colors.orange,
               // child: Image.asset(Assets.iconsEditprofile),
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomTextFrom(label: 'Full Name', hint: 'Hosam Adel'),
              const SizedBox(
                height: 20,
              ),
              const CustomTextFrom(label: 'Email', hint: 'hosam@gmail.com'),
              const SizedBox(
                height: 20,
              ),
              const CustomTextFrom(label: 'Phone Number', hint: '01098894833'),
              const SizedBox(
                height: 30,
              ),
              CustomSendButton(
                label: 'Save',
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title, this.widget, this.onTap});
  final String title;
  final Widget? widget;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          GestureDetector(
              onTap: onTap ??
                  () {
                    Navigator.pop(context);
                  },
              child: Image.asset(Assets.iconsBack)),
          const SizedBox(width: 20),
          Text(
            title,
            style: AppStyles.style18(context),
          ),
          const Spacer(),
          widget ?? const SizedBox()
        ],
      ),
    );
  }
}
