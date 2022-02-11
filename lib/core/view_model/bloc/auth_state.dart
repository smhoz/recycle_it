part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.unknown,
    this.user,
  });

  final AuthStatus status;
  final User? user;
  @override
  List<Object?> get props => [status, user];
}

class AuthUnknown extends AuthState {
  const AuthUnknown() : super(status: AuthStatus.unknown);
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated(User user)
      : super(status: AuthStatus.authenticated, user: user);
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated() : super(status: AuthStatus.unauthenticated);
}
