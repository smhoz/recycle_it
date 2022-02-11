import 'package:firebase_auth_rest/firebase_auth_rest.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hackathon_app/core/consts/keys.dart';
import 'package:hackathon_app/core/model/user_model.dart';
import 'package:hackathon_app/core/repository/auth_repository.dart';
import 'package:hackathon_app/core/utils/db_manager.dart';
import 'package:hackathon_app/core/utils/locator_get_it.dart';

class GlobalRepository {
  User? _user;
  User? get user => _user;

  final DBManager tokenCache = TokenCacheManager(Keys.token);

  Future<void> tokenInit() async {
    await tokenCache.init();
  }

  late AuthService authService;
  void authServiceInit() {
    authService = AuthService(dotenv.env['FIREBASE_API_KEY'] as String);
  }

  Future<void> tryGetCurrentUser() async {
    _user = await getIt<AuthRepository>().tryGetCurrentUser();
  }
}
