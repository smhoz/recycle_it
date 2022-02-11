import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/utils/locator_get_it.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    initalFunction();
  }

  Future<void> initalFunction() async {
    await Hive.initFlutter();

    setupGetIt();
    List<Future> futures = [dotenv.load(fileName: ".env"), getIt.allReady()];

    await Future.wait(futures);
    emit(SplashCompleted());
  }
}
