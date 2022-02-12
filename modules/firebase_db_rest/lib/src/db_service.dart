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
    try {
      Response _response = await _dio.post("/users.json", data: data);
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
      final _query =
          'https://hackathon-app-2022-default-rtdb.europe-west1.firebasedatabase.app/users.json?orderBy="uid"&equalTo="$spesificId"';
      Dio _newDio = Dio();
      Response _response = await _newDio.get(_query);
      if (_response.statusCode == 200) {
        Map _result = _response.data;
        late dynamic _lastData;
        _result.forEach((key, value) => _lastData = value);
        return _lastData;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
