import 'package:flutter/material.dart';
import 'package:my_visitor/constants.dart';

class UserDetailsSection extends StatelessWidget {
  const UserDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: redColor,
        radius: 50,
      ),
      title: Text('HOSAM'),
      subtitle: Text(
        'click to get more options',
        style: TextStyle(fontSize: 10, color: Colors.grey),
      ),
    );
  }
}
