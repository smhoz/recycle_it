import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_app/core/utils/locator_get_it.dart';
import 'package:hackathon_app/view/pages/home_page/components/profile_component/profile_body.dart';

import 'bloc/profile_bloc.dart';

class ProfileComponent extends StatelessWidget {
  const ProfileComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileBloc>(),
      child: const ProfileBody(),
    );
  }
}
