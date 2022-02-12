part of 'profileform_cubit.dart';

abstract class ProfileformState extends Equatable {
  const ProfileformState();

  @override
  List<Object> get props => [];
}

class ProfileformInitial extends ProfileformState {}

class ProfileformLoading extends ProfileformState {}

class ProfileformCompleted extends ProfileformState {}

class ProfileformError extends ProfileformState {
  final String? errorMessage;
  const ProfileformError({
    this.errorMessage,
  });
}

class ProfileformButtonActive extends ProfileformState {}

class ProfileformButtonPassive extends ProfileformState {}
