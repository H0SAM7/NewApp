import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:my_visitor/features/admins/data/admins_repo/admins_repo_impl.dart';
import 'package:my_visitor/features/admins/data/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());

  Future<void> addProduct( {required ProductModel productModel}) async {
    emit(AdminLoading());
    try {
      await AdminsRepoImpl().addProduct(productModel: productModel);
      emit(AdminSuccess());
    } catch (e) {
      emit(AdminFailure(errMessage: e.toString()));
    }
  }

  Future<void> deleteProduct({required String parcode}) async {
    emit(AdminLoading());
    try {
      await AdminsRepoImpl().deleteProduct(parcode: parcode);
      emit(AdminSuccess());
    } catch (e) {
      emit(AdminFailure(errMessage: e.toString()));
    }
  }

  Future<void> updateProduct() async {
    emit(AdminLoading());
    try {
      emit(AdminSuccess());
    } catch (e) {
      emit(AdminFailure(errMessage: e.toString()));
    }
  }


  final ImagePicker _picker = ImagePicker();
  final SupabaseClient supabase = Supabase.instance.client;
  String? _imageLink;
  String? get imageLink => _imageLink;

  Future<String> uploadImage({required XFile image}) async {
    try {
      // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      // if (image == null) {
      //   throw Exception("لم يتم اختيار صورة");
      // }

      File file = File(image.path);
      String fileName = "images/${DateTime.now().millisecondsSinceEpoch}.jpg";

      await supabase.storage.from('images').upload(fileName, file);

      final String publicUrl =
          supabase.storage.from('images').getPublicUrl(fileName);
      _imageLink = publicUrl;

      log("✅ تم رفع الصورة وحفظ الرابط بنجاح!");

      return publicUrl;
    } catch (e) {
      log("❌ خطأ: $e");
      return ""; // Return an empty string if an error occurs
    }
  }

//  final SupabaseClient supabase = Supabase.instance.client;
//   final ImagePicker _picker = ImagePicker();

//   Future<String?> uploadImage(String fileName) async {
//     try {
//       final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

//       if (pickedFile != null) {
//         File file = File(pickedFile.path);

//         // Read file as bytes
//         final fileBytes = await file.readAsBytes();

//         // Upload file to Supabase storage
//         final String filePath = 'images/$fileName';
//         await supabase.storage.from('images').uploadBinary(filePath, fileBytes);

//         // Generate a public URL for the uploaded file
//         final publicUrl = supabase.storage.from('images').getPublicUrl(filePath);

//         return publicUrl;
//       }
//     } catch (e) {
//       log('Error uploading image: $e');
//     }
//     return null;
//   }

//   Future<String?> getDownloadUrl(String filePath) async {
//     try {
//       String downloadUrl = supabase.storage.from('images').getPublicUrl(filePath);
//       return downloadUrl;
//     } catch (e) {
//       log('Error getting download URL: $e');
//       return null;
//     }
//   }

  // Future<String?> uploadImage(String fileName,) async {
  //   try {
  //     final XFile? pickedFile =
  //         await _picker.pickImage(source: ImageSource.gallery);

  //     if (pickedFile != null) {
  //       File file = File(pickedFile.path);

  //       Reference storageRef =
  //           _storage.ref().child('FunnyBabyimages/$fileName');

  //       UploadTask uploadTask = storageRef.putFile(file);

  //       TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});

  //       String downloadUrl = await snapshot.ref.getDownloadURL();

  //       return downloadUrl;
  //     }
  //   } catch (e) {
  //     log('Error uploading image: $e');
  //   }
  //   return null;
  // }

  // final FirebaseStorage _storage = FirebaseStorage.instance;
  // final ImagePicker _picker = ImagePicker();

  // Future<String?> getDownloadUrl(String filePath) async {
  //   try {
  //     String downloadUrl = await _storage.ref(filePath).getDownloadURL();
  //     return downloadUrl;
  //   } catch (e) {
  //     log('Error getting download URL: $e');
  //     return null;
  //   }
  // }
}
