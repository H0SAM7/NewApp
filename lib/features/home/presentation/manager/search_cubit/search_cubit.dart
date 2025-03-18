import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:my_visitor/features/admins/data/models/product_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());


Future<ProductModel?> searchProductByName(String productName) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('products') 
        .where('name', isEqualTo: productName)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Assuming you want the first match
      DocumentSnapshot doc = querySnapshot.docs.first;
      return ProductModel.fromDocument(doc);
    } else {
      log('No products found with the name $productName');
      return null;
    }
  } catch (e) {
    log('Error searching for product: $e');
    return null;
  }
}
}