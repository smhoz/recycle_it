import 'package:get_it/get_it.dart';
import 'package:hackathon_app/core/repository/auth_repository.dart';
import 'package:hackathon_app/view/pages/home_page/components/profile_component/bloc/profile_bloc.dart';
import 'package:hackathon_app/view/pages/home_page/components/profile_component/child_page/cubit/balance_cubit.dart';

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
