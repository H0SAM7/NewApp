import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_visitor/features/admins/data/admins_repo/admins_repo.dart';
import 'package:my_visitor/features/admins/data/models/product_model.dart';


class AdminsRepoImpl extends AdminsRepo {

  @override
  Future<void> addProduct({required ProductModel productModel}) async {
    try {
      await firestore.collection('products').add(productModel.toMap());
      log('adding done');
    } catch (e) {
      log('Error adding product: $e');
    }
  }

  @override
  Future<void> deleteProduct({required String parcode}) async {
    try {
      // Query the collection to find the document with the matching parcode
      QuerySnapshot querySnapshot = await firestore
          .collection('products')
          .where('parcode', isEqualTo: parcode)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the document ID of the first matching document
        String docId = querySnapshot.docs.first.id;

        // Delete the document with the matching ID
        await firestore.collection('products').doc(docId).delete();
        log('Product with parcode $parcode deleted successfully.');
      } else {
        log('No product found with parcode $parcode');
      }
    } catch (e) {
      log('Error deleting product: $e');
    }
  }

  @override
  Future<void> updateProduct({required ProductModel productModel}) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}
