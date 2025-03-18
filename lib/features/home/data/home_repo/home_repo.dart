import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:my_visitor/core/error/firebase_failure.dart';
import 'package:my_visitor/features/admins/data/models/discount_model.dart';
import 'package:my_visitor/features/admins/data/models/product_model.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

final FirebaseStorage storage = FirebaseStorage.instance;

abstract class HomeRepo {
  Future<Either<Failure, List<ProductModel>>> getAllProducts();
  Future<Either<Failure, List<DiscountModel>>> getAllDiscounts();

}
