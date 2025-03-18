
import 'package:cloud_firestore/cloud_firestore.dart';

class DiscountModel {
  String sale, image;
  DiscountModel({required this.sale, required this.image});
  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'sale': sale,
      'image': image,
    };
  }

  factory DiscountModel.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return DiscountModel(sale: data['sale'], image: data['image']);
  }
}
