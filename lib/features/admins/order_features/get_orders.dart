 
  import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_visitor/features/admins/data/models/order_model.dart';

Future<List<OrderModel>> fetchOrders() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot = await firestore.collection('orders').get();

      // Map each document to an OrderModel
      List<OrderModel> orders = querySnapshot.docs.map((doc) {
        return OrderModel.fromDocument(doc);
      }).toList();

      return orders;
    } catch (e) {
      log("Error fetching orders: $e");
      return [];
    }
  }