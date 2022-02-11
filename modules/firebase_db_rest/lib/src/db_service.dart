import 'package:dio/dio.dart';

class DBService {
  final String databaseId;

  late Dio _dio;
  late BaseOptions _baseOptions;
  DBService(this.databaseId) {
    _dio = Dio();
    _baseOptions = BaseOptions(baseUrl: databaseId);
    _dio.options = _baseOptions;
  }

  Future<bool> postUserData({required Map data, required String id}) async {
    Map _result = {id: data};
    try {
      Response _response = await _dio.put("/users.json", data: _result);
      if (_response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getUserData({required String spesificId}) async {
    try {
      Response _response = await _dio.get("/users/$spesificId.json");
      if (_response.statusCode == 200) {
        return _response.data;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
