part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginCompleted extends LoginState {}

class LoginError extends LoginState {
  final String? errorMessage;
  const LoginError({
    this.errorMessage,
  });
}
