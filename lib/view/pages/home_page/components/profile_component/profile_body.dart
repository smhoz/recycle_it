import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_app/core/navigation/navigation_manager.gr.dart';
import 'package:hackathon_app/core/repository/auth_repository.dart';
import 'package:hackathon_app/view/pages/home_page/components/profile_component/profile_form/profile_form.dart';

import '../../../../../core/utils/locator_get_it.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [const _CircleAvatar(), ProfileForm(), const _LogOutButton()],
      ),
    );
  }
}

class _CircleAvatar extends StatelessWidget {
  const _CircleAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Profile', style: Theme.of(context).textTheme.headline4),
        const FlutterLogo(
          size: 72,
        ),
      ],
    );
  }
}

class _LogOutButton extends StatelessWidget {
  const _LogOutButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => getIt<AuthRepository>().signOut().then(
          (value) => context.router.replaceAll([const AuthControllerRoute()])),
      icon: const Icon(
        Icons.exit_to_app,
      ),
      label: const Text('Log Out'),
    );
  }
}
