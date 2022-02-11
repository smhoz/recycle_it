import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hackathon_app/core/model/user_model.dart';
import 'package:hackathon_app/core/repository/auth_repository.dart';
import 'package:hackathon_app/core/utils/locator_get_it.dart';

import '../../repository/global_repositor.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthUnknown()) {
   on<AuthTryGetCurrentUser>(_tryGetCurrentUser);
     add(AuthTryGetCurrentUser());
  }

  
  Future<void> _tryGetCurrentUser(
      AuthTryGetCurrentUser event, Emitter<AuthState> emit) async {
    final _repo = getIt<GlobalRepository>();
    await _repo.tryGetCurrentUser();
    if (_repo.user != null) {
      emit(AuthAuthenticated(_repo.user!));
    } else {
      emit(const AuthUnauthenticated());
    }
  }
}
