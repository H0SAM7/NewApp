import 'package:flutter/material.dart';
import 'package:my_visitor/features/admins/data/models/product_model.dart';
import 'package:my_visitor/features/cart/presentation/views/widgets/cart_view_item.dart';
import 'package:my_visitor/features/home/presentation/views/widgets/custom_product_item.dart';



class CartListView extends StatelessWidget {
  const CartListView({
    super.key,
    required this.products, this.onPressed,
  });
final void Function()? onPressed;
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: products.length,
        itemBuilder: (context, ind) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: CustomProductItem(
              productModel: products[ind],
              // onPressed: onPressed,
            ),
          );
        });
  }
}
