import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_app/view/pages/home_page/components/map_component/map_component.dart';
import 'package:hackathon_app/view/pages/home_page/components/shop_component/shop_component.dart';

import '../components/profile_component/profile_component.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const BottomInitial(MapComponent()));
  onIndexChange(int index) {
    switch (index) {
      case 0:
        emit(HomeChanged(const MapComponent(), index));
        break;
      case 1:
        emit(HomeChanged(const ShopComponent(), index));
        break;
      case 2:
        emit(HomeChanged(const ProfileComponent(), index));
        break;
      default:
        emit(HomeChanged(const MapComponent(), index));
        break;
    }
  }
}
