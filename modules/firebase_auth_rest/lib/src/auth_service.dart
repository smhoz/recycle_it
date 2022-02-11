import 'package:dio/dio.dart';
import 'firebase_uri.dart';

class AuthService {
  final String firebaseApiKey;
  late FirebaseURI _restURI;
  late Dio _dio;
  late BaseOptions _baseOptions;
  AuthService(this.firebaseApiKey) {
    _restURI = FirebaseURI(firebaseApiKey);
    _dio = Dio();
    _baseOptions = BaseOptions(baseUrl: _restURI.baseUri);
    _dio.options = _baseOptions;
  }

  Future<String?> signInAndGetUid(
      {required String mail, required String password}) async {
    try {
      Map _data = {
        "email": mail,
        "password": password,
        "returnSecureToken": true
      };
      Response _response = await _dio.post(_restURI.signInUri, data: _data);
      if (_response.statusCode == 200) {
        return _response.data['localId'];
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> signInAndGetIdToken(
      {required String mail, required String password}) async {
    try {
      Map _data = {
        "email": mail,
        "password": password,
        "returnSecureToken": true
      };
      Response _response = await _dio.post(_restURI.signInUri, data: _data);
      if (_response.statusCode == 200) {
        return _response.data['idToken'];
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> changePassword(
      {required String idToken, required String newPassword}) async {
    try {
      Map _data = {
        "idToken": idToken,
        "password": newPassword,
        "returnSecureToken": true
      };
      Response _response =
          await _dio.post(_restURI.changePassword, data: _data);
      if (_response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> signUpAndGetUid(
      {required String mail, required String password}) async {
    try {
      Map _data = {
        "email": mail,
        "password": password,
        "returnSecureToken": true
      };

      Response _response = await _dio.post(_restURI.signUpUri, data: _data);

      if (_response.statusCode == 200) {
        return _response.data['localId'];
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
