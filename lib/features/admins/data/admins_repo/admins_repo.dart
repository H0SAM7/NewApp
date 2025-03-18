import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:my_visitor/features/admins/data/models/discount_model.dart';
import 'package:my_visitor/features/admins/data/models/product_model.dart';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseStorage storage = FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();
abstract class AdminsRepo {
  
  Future<void> addProduct({required ProductModel productModel});
  Future<void> deleteProduct({required String parcode});
  Future<void> updateProduct({required ProductModel productModel});
  Future<void> addDiscount({required DiscountModel discountModel});
 // Future<void> deleteDiscount({required DiscountModel discountModel});
}
