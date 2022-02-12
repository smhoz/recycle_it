import 'package:firebase_db_rest/firebase_db_rest.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hackathon_app/core/model/user_model.dart';

import '../utils/json_webtoken.dart';

abstract class IUserService {
  Future<User?> readUserData({required String token});
  Future<bool> signUp({
    required String uid,
    required String name,
    required String surname,
    required String mail,
  });
  Future<bool> updateUserData(
      {required String uid, String? name, String? surname, String? mail});
}

class UserService implements IUserService {
  final _dbService = DBService(dotenv.env['DATABASE_ID'] as String);
  @override
  Future<User?> readUserData({required String token}) async {
    final _userId = JwtManager().verifyJwt(token)["uid"];
    if (_userId != null) {
      final _result = await _dbService.getUserData(spesificId: _userId);
      User _user = User.fromMap(_result);
      return _user;
    } else {
      return null;
    }
  }

  @override
  Future<bool> signUp({
    required String uid,
    required String name,
    required String surname,
    required String mail,
  }) async {
    User _data =
        User(mail: mail, name: name, surname: surname, uid: uid, balance: "0");
    bool _result =
        await _dbService.postUserData(data: _data.toMap(), id: _data.uid ?? "");
    return _result;
  }

  @override
  Future<bool> updateUserData(
      {required String uid,
      String? name,
      String? surname,
      String? mail}) async {
    User _data =
        User(mail: mail, name: name, surname: surname, uid: uid, balance: "0");
    bool _result =
        await _dbService.updateUser(map: _data.toMap(), spesificId: uid);
    return _result;
  }
}
