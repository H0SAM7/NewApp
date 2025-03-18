import 'package:flutter/material.dart';
import 'package:my_visitor/constants.dart';
import 'package:my_visitor/core/widgets/custom_button.dart';
import 'package:my_visitor/features/auth/screens/widgets/custom_text_field.dart';
import 'package:my_visitor/services/technical_support_messages.dart';

class TechnicalSupportView extends StatefulWidget {
  const TechnicalSupportView({super.key});
  static String id = 'TechnicalSupportView';

  @override
  _TechnicalSupportViewState createState() => _TechnicalSupportViewState();
}

class _TechnicalSupportViewState extends State<TechnicalSupportView> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the text controllers when the widget is disposed
    phoneController.dispose();
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Technical Support'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'اذا كنت تواجه مشكلة في التطبيق او لديك شكوي ',
                    style: TextStyle(
                      color: orangeColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              CustomTextFrom(
                label: 'رقم هاتفك ',
                hint: '',
                controller: phoneController,
                onChanged: (value) {
                  phoneController.text = value;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFrom(
                label: 'عنوان الشكوي',
                hint: '',
                controller: titleController,
                onChanged: (value) {
                  titleController.text = value;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFrom(
                label: 'الشكوي',
                hint: '',
                controller: contentController,
              
                onChanged: (value) {
                  contentController.text = value;
                },
              ),
              const SizedBox(height: 32),
              CustomButton(
                title: 'ارسال',
                color: orangeColor,
              
                onTap: () async {
                  // Get the input data
                  String phone = phoneController.text.trim();
                  String title = titleController.text.trim();
                  String content = contentController.text.trim();

                  await TechnicalSupportMessages().technicalSupportMessage(
                    context: context,
                      title: title, content: content, phoneNumber: phone);
                  phoneController.clear();
                  titleController.clear();
                  contentController.clear();
        
                  // Provide feedback to the user (e.g., show a snackbar)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('تم إرسال الشكوى بنجاح')),
                  );
             //     GoRouter.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
