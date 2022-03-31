import 'package:get_it/get_it.dart';

import '../../view/home/profile_page/viewmodel/bloc/profile_bloc.dart';
import '../../view/home/profile_page/viewmodel/cubit/balance_cubit.dart';
import '../repository/auth_repository.dart';
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

  getIt.registerLazySingleton<ProfileBloc>(() => ProfileBloc());
  getIt.registerLazySingleton<BalanceCubit>(() => BalanceCubit());
}
