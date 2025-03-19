import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddToCartWidget extends StatelessWidget {
  const AddToCartWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    
 // final S s=S.of(context);
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
     Icon(
          FontAwesomeIcons.cartShopping,
          color: Colors.white,
        ),
          SizedBox(width: 20,
        ),
        Text(
          "Add To Cart",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        SizedBox(width: 20,
        ),
        
      ],
    );
  }
}
