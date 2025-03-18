import 'package:flutter/material.dart';
import 'package:my_visitor/core/widgets/custom_err_view.dart';
import 'package:my_visitor/core/widgets/custom_loading_indecator.dart';

import 'package:my_visitor/features/admins/data/models/order_model.dart';
import 'package:my_visitor/features/admins/order_features/get_orders.dart';
import 'package:my_visitor/features/admins/order_features/views/widgets/order_list_view.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});
  static String id = 'OrdersView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<OrderModel>>(
        future: fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CustomLoadingIndicator());
          }

          if (snapshot.hasError) {
            return const CustomErrView();
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No orders available'));
          }

          List<OrderModel> orders = snapshot.data!;

          return OrdersListView(orders: orders);
        },
      ),
    );
  }
}

