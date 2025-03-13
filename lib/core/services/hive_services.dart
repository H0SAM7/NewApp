// import 'dart:developer';
// import 'package:vistor/core/models/user_model.dart';
// import 'package:hive/hive.dart';
// class HiveServices {
  
// // Ensure the box is initialized with a dynamic name
// Future<Box<UserModel>> getUserBox(String boxName) async {
//   if (!Hive.isBoxOpen(boxName)) {
//     return await Hive.openBox<UserModel>(boxName);
//   }
//   return Hive.box<UserModel>(boxName);
// }

// // Add a user to the box with a dynamic name
// Future<void> addUser(String boxName, UserModel user) async {
//   try {
//     var userBox = await getUserBox(boxName);
//     await userBox.add(user);
//   } catch (e) {
//     log('Error adding user: ${e.toString()}');
//   }
// }

// // Fetch all users from the box with a dynamic name
// Future<List<UserModel>> fetchAllItems(String boxName) async {
//   try {
//     var userBox = await getUserBox(boxName);
//     return userBox.values.toList();
//   } catch (e) {
//     log('Error fetching items: ${e.toString()}');
//     return [];
//   }
// }

// // Clear all users from the box with a dynamic name
// Future<void> clearCart(String boxName) async {
//   try {
//     var userBox = await getUserBox(boxName);
//     await userBox.clear();
//   } catch (e) {
//     log('Error clearing cart: ${e.toString()}');
//   }
// }

// }