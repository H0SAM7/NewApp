import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_visitor/core/styles/text_styles.dart';
import 'package:my_visitor/features/cart/manager/cart_cubit/cart_cubit.dart';
import 'package:my_visitor/features/cart/views/widgets/cart_view_body.dart';
import 'package:my_visitor/profile/views/widgets/widgets/my_products_body.dart';

class MyProductsView extends StatefulWidget {
  const MyProductsView({super.key});
  static String id = 'MyProductsView';
  @override
  State<MyProductsView> createState() => _MyProductsView();
}

class _MyProductsView extends State<MyProductsView> {
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
          'My Products',
          style: AppStyles.style32(context, Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: MyProductsBody(),
    );
  }
}
