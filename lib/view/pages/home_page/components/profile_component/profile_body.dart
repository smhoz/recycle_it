import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hackathon_app/core/consts/navigation_const.dart';
import 'package:hackathon_app/core/extensions/context_extension.dart';
import 'package:hackathon_app/core/navigation/navigation_manager.gr.dart';
import 'package:hackathon_app/core/repository/auth_repository.dart';
import 'package:hackathon_app/core/repository/global_repositor.dart';
import 'package:hackathon_app/view/pages/home_page/components/profile_component/profile_form/profile_form.dart';

import '../../../../../core/utils/locator_get_it.dart';
import 'bloc/profile_bloc.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _CircleAvatar(),
            BlocBuilder<ProfileBloc, ProfileState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                return ProfileForm();
              },
            ),
            const _CardContainer(),
            const _LogOutButton()
          ],
        ),
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

class _CardContainer extends StatelessWidget {
  const _CardContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.orange[400],
      ),
      margin: const EdgeInsets.all(10.0),
      height: 70.0,
      child: ListTile(
        onTap: () => context.router.pushNamed(RouteConsts.WALLET_PAGE),
        leading: const CircleAvatar(
          backgroundColor: Colors.grey,
        ),
        title: Text(
          "My Wallet",
          style: context.textTheme.headline5,
        ),
        subtitle: BlocBuilder<ProfileBloc, ProfileState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            return Text(
                (getIt<GlobalRepository>().user?.balance ?? 0).toString());
          },
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
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
