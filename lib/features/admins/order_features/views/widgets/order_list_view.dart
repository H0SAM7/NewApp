
import 'package:flutter/material.dart';

import 'package:my_visitor/features/admins/data/models/order_model.dart';
import 'package:my_visitor/features/admins/order_features/views/widgets/order_list_view_item.dart';

class OrdersListView extends StatelessWidget {
  const OrdersListView({
    super.key,
    required this.orders,
  });

  final List<OrderModel> orders;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        OrderModel order = orders[index];
        return OrdersListViewItem(order: order);
      },
    );
  }
}
