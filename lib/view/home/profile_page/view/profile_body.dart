import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/consts/navigation_const.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/init/theme/color/custom_colors.dart';
import '../../../../core/navigation/navigation_manager.gr.dart';
import '../../../../core/repository/auth_repository.dart';
import '../../../../core/repository/global_repositor.dart';
import '../../../../core/utils/border/custom_border_radius.dart';

import '../../../../../../core/utils/locator_get_it.dart';
import '../viewmodel/bloc/profile_bloc.dart';
import 'profile_form.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(height: 50),
            const CircleAvatar(
                child: FlutterLogo(
                  size: 120,
                ),
                backgroundColor: Colors.transparent),
            BlocBuilder<ProfileBloc, ProfileState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                return ProfileForm();
              },
            ),
            const _WalletContainer(),
            const _LogOutButton(),
          ],
        ),
      ),
    );
  }
}

class _WalletContainer extends StatelessWidget {
  const _WalletContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: CustomBorderRadius.highCircular(),
          color: context.themeColor.primary,
          boxShadow: [CustomColors.instance.containerBoxShadow]),
      margin: context.paddingLow,
      height: context.height * 0.10,
      child: ListTile(
        leading: const Icon(
          Icons.account_balance_wallet_outlined,
          size: 32,
        ),
        title: Text(
          "Cüzdanım",
          style: context.textTheme.headline1,
        ),
        subtitle: BlocBuilder<ProfileBloc, ProfileState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            return Row(children: [
              Icon(
                Icons.circle,
                color: CustomColors.instance.coinColor,
                size: 24,
              ),
              SizedBox(
                width: context.width * 0.02,
              ),
              Text(((getIt<GlobalRepository>().user?.balance) ?? 0).toString())
            ]);
          },
        ),
        trailing: IconButton(
            onPressed: (() {
              context.router.pushNamed(RouteConsts.WALLET_PAGE);
            }),
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 24,
            )),
      ),
    );
  }
}

/* 


*/

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
