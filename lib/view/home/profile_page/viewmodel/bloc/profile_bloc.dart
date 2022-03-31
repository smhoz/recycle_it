import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/utils/locator_get_it.dart';
import '../../../../../core/repository/global_repositor.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final _globalRepo = getIt<GlobalRepository>();
  ProfileBloc() : super(ProfileInitial()) {
    on<GetProfileUpdatedValues>(_getProfileUpdatedValue);
  }

  Future<void> _getProfileUpdatedValue(
      GetProfileUpdatedValues event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadgin());
    await _globalRepo.tryGetCurrentUser();
    emit(ProfileCompleted());
  }
}
