import 'package:dio/dio.dart';

class DioServices {
  final dio = Dio();

  Future<Map<String, dynamic>> get(
      {required String url,}) async {
    Response response = await Dio().get('$url');
    return response.data;
  }
}
