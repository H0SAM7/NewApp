
import 'package:flutter/material.dart';
import 'package:my_visitor/features/Notifications/views/widgets/notifi_view_item.dart';

class NotifiListView extends StatelessWidget {
  const NotifiListView({super.key, required this.notificationsList});
  final List<Map<String, String>> notificationsList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: notificationsList.length,
        itemBuilder: (context, ind) {
          final notification = notificationsList[ind];
          return NotifiItemView(
            title:notification['title'] !,
            subtitle: notification['body']!,
             );
        });
  }
}
