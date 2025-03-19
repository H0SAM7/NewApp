import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:my_visitor/core/error/firebase_failure.dart';
import 'package:my_visitor/features/admins/data/models/product_model.dart';
import 'package:my_visitor/features/home/data/home_repo/home_repo.dart';

class HomeRepoImp extends HomeRepo {

  @override
  Future<Either<Failure, List<ProductModel>>> getAllProducts() async {
    try {
      QuerySnapshot querySnapshot =
          await firestore.collection('products').get();
      List<ProductModel> products = querySnapshot.docs
          .map((doc) => ProductModel.fromDocument(doc))
          .toList();
      return right(products);
    } catch (e) {
      log('Error getting products: $e');
      return left(FirebaseFailure.fromFirebaseException(e as Exception));
    }
  }



  
}
