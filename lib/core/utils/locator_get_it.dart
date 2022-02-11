import 'package:get_it/get_it.dart';
import 'package:hackathon_app/core/repository/auth_repository.dart';

import '../repository/global_repositor.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingletonAsync<GlobalRepository>(() async {
    final _result = GlobalRepository();
    await _result.tokenInit();
    _result.authServiceInit();
    return _result;
  });
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
}
