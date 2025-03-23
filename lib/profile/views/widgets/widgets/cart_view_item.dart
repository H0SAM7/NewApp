import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_visitor/features/admins/data/models/product_model.dart';
import 'package:my_visitor/features/cart/manager/cart_cubit/cart_cubit.dart';
import 'package:my_visitor/features/home/presentation/views/widgets/custom_image_procduct.dart';

class CartViewItem extends StatelessWidget {
  const CartViewItem({super.key, required this.product, this.onPressed,});
final ProductModel product;
final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return  ListTile(
      leading: CustomImage(image: product.image),
      title: Text(product.title),
      subtitle: Text("Free"),
      trailing:  IconButton(icon: const Icon( Icons.delete),onPressed: (){
         product.delete();
         BlocProvider.of<CartCubit>(context).fetchAllItems();
      }
     
     ),
    );
  }
}