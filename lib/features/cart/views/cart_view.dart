import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_visitor/core/styles/text_styles.dart';
import 'package:my_visitor/features/cart/manager/cart_cubit/cart_cubit.dart';
import 'package:my_visitor/features/cart/views/widgets/cart_view_body.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});
  static String id = 'CartView';
  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    BlocProvider.of<CartCubit>(context).fetchAllItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(
        title: Text(
          'Cart',
          style: AppStyles.style32(context, Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: CartViewBody(),
    );
  }
}
