import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_visitor/features/admins/data/models/product_model.dart';

class FireBaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  // Future<void> addProduct(ProductModel product) async {
  //   try {
  //     await _firestore.collection('products').add(product.toMap());
  //     log('adding done');
  //   } catch (e) {
  //     log('Error adding product: $e');
  //   }
  // }

  Future<List<ProductModel>> getProducts() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('products').get();
      return querySnapshot.docs
          .map((doc) => ProductModel.fromDocument(doc))
          .toList();
    } catch (e) {
      log('Error getting products: $e');
      return [];
    }
  }

  Future<List<ProductModel>> getCategoryProducts(
    String category,
  ) async {
    try {
      List<ProductModel> list = await getProducts();
      List<ProductModel> categoryProducts = [];
      for (var product in list) {
        if (category == product.category) {
          categoryProducts.add(product);
        }
      }
      return categoryProducts;
    } catch (e) {
      log('Error getting products: $e');
      return [];
    }
  }
    

  Future<void> updateProduct(ProductModel product) async {
    try {
      await _firestore
          .collection('products')
          .doc(product.code)
          .update(product.toMap());
    } catch (e) {
      log('Error updating product: $e');
    }
  }

 
Future<void> updateField(String fieldName, bool newValue, ProductModel productModel) async {

  await FirebaseFirestore.instance
      .collection('products')  
      .doc(productModel.code)
      .update({fieldName: newValue})
      .then((_) {
    log("Field updated successfully");
  }).catchError((error) {
    log("Error updating field: $error");
  });
}



// Future<void> deleteProduct(String parcode) async {
//   try {
//     // Query the collection to find the document with the matching parcode
//     QuerySnapshot querySnapshot = await _firestore
//         .collection('products')
//         .where('parcode', isEqualTo: parcode)
//         .get();

//     if (querySnapshot.docs.isNotEmpty) {
//       // Get the document ID of the first matching document
//       String docId = querySnapshot.docs.first.id;

//       // Delete the document with the matching ID
//       await _firestore.collection('products').doc(docId).delete();
//       log('Product with parcode $parcode deleted successfully.');
//     } else {
//       log('No product found with parcode $parcode');
//     }
//   } catch (e) {
//     log('Error deleting product: $e');
//   }
// }


}


// Future<void> addSale(DiscountModel sale) async {
//     try {
//       await _firestore.collection('sales').add(sale.toMap());
//       log('adding done');
//     } catch (e) {
//       log('Error adding product: $e');
//     }
//   }
// }
