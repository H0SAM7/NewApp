import 'dart:convert';
import 'dart:developer';

import 'package:my_visitor/constants.dart';
import 'package:my_visitor/core/utils/assets.dart';
import 'package:my_visitor/core/widgets/show_custom_alert.dart';
import 'package:my_visitor/features/Notifications/services/send_notifications.dart';
import 'package:my_visitor/features/auth/screens/widgets/custom_send_button.dart';
import 'package:my_visitor/features/auth/screens/widgets/custom_text_field.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class SendNotifactionsSendView extends StatefulWidget {
  const SendNotifactionsSendView({super.key});
  static String id = 'SendNotifactionsSendView';
  @override
  // ignore: library_private_types_in_public_api
  _sendNotifactionsSendViewState createState() => _sendNotifactionsSendViewState();
}

// ignore: camel_case_types
class _sendNotifactionsSendViewState extends State<SendNotifactionsSendView> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subTitlecontroller = TextEditingController();

  String accessToken = '';

  getToken() async {
    var mytoken = await FirebaseMessaging.instance.getToken();
    log('My token ================  ${mytoken.toString()}');
  }

  @override
  void initState() {
    getToken();
    super.initState();
    getAccessToken();
  }

  Future<void> getAccessToken() async {
    try {
      final serviceAccountJson = await rootBundle.loadString(
        'assets/adminsdk.json');

      final accountCredentials = ServiceAccountCredentials.fromJson(
        json.decode(serviceAccountJson),
      );

      const scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

      final client = http.Client();
      try {
        final accessCredentials =
            await obtainAccessCredentialsViaServiceAccount(
          accountCredentials,
          scopes,
          client,
        );

        setState(() {
          accessToken = accessCredentials.accessToken.data;
        });

        log('Access Token: $accessToken');
      } catch (e) {
        log('Error obtaining access token: $e');
      } finally {
        client.close();
      }
    } catch (e) {
      log('Error loading service account JSON: $e');
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    subTitlecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Notification'),
        elevation: 0,
        backgroundColor: orangeColor,
      ),
      body: Column(
        children: [
          CustomTextFrom(
            hint: '',
            label: "title",
            onChanged: (value) {
              titleController.text = value;
            },
          ),
          CustomTextFrom(
            hint: '',
            label: "subtitle",
            onChanged: (value) {
              subTitlecontroller.text = value;
            },
          ),
          CustomSendButton(
            label: 'Send',
            color: orangeColor,
            txtcolor: Colors.white,
            onTap: () async {
              try {
                await NotificationsServices().sendNotification(
                  titleController.text,
                  subTitlecontroller.text,
                  accessToken,
                );
                showCustomAlert(
                    context: context,
                    type: AlertType.success,
                    title: '',
                    description: 'Send done',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    actionTitle: 'Ok');

                log('send message done');
                Navigator.pop(context);
              } catch (e) {
                log('send message err:$e');
              }
            },
          ),
          // IconButton(
          //     onPressed: () async {
          //       await NotificationsServices().sendNotification(
          //           'welcome', 'can i help you?', accessToken);
          //       log('send message done');
          //     },
          //     icon: Icon(
          //       Icons.import_contacts,
          //       size: 150,
          //     )),
        ],
      ),
    );
  }
}
