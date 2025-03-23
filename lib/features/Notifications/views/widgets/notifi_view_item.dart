
import 'package:flutter/material.dart';
import 'package:my_visitor/constants.dart';
import 'package:my_visitor/core/styles/text_styles.dart';
import 'package:my_visitor/core/utils/assets.dart';

class NotifiItemView extends StatelessWidget {
  const NotifiItemView({super.key,  this.image,required  this.title,required  this.subtitle});
final String? image;
final String title;

final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: redColor),
          borderRadius: BorderRadius.circular(16)
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color.fromARGB(103, 73, 9, 9),
              child: Image.asset(
            Assets.iconsNotifiIcon,
            fit: BoxFit.fill,
          )),
          title: Text(
            title
            
          ,
            style: AppStyles.style18(context),
          ),
          subtitle:  Text(subtitle),
        ),
      ),
    );
  }
}
