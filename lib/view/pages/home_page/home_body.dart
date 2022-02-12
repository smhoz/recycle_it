import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_app/core/repository/global_repositor.dart';
import 'package:hackathon_app/core/utils/locator_get_it.dart';
import 'package:hackathon_app/view/pages/home_page/cubit/home_cubit.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = getIt<GlobalRepository>().user;
    return BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => state.component);
  }
}
