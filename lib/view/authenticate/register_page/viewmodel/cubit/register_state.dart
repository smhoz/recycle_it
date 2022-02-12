part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterCompleted extends RegisterState {}

class RegisterError extends RegisterState {
  final String? errorMessage;
  const RegisterError({
    this.errorMessage,
  });
}
