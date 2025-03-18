import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_visitor/features/admins/data/models/discount_model.dart';

class DiscountViewItem extends StatelessWidget {
  final DiscountModel sale;

  const DiscountViewItem({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          left: size.width * .0188,
          right: size.width * .0188,
          bottom: size.height * .05),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Container(
              height: size.height * 0.5,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider( sale.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: size.height * 0.5,
              width: size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.1)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
