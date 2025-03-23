
import 'package:flutter/material.dart';
import 'package:my_visitor/features/auth/screens/widgets/custom_send_button.dart';
import 'package:my_visitor/features/auth/screens/widgets/custom_text_field.dart';

class AddNewAddressView extends StatelessWidget {
  const AddNewAddressView({super.key});
  static String id = 'AddNewAddressView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
           // child: Image.asset(Assets.iconsMAp),
          ),
          const CustomTextFrom(
            label: 'Address',
            hint: 'Shoag - Egypt',
          ),
          TextButton.icon(
            onPressed: () {},
            label: const Text('Location'),
            icon: const Icon(Icons.location_on),
          ),
          const SizedBox(
            height: 40,
          ),
          CustomSendButton(
            label: 'Save location',
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
