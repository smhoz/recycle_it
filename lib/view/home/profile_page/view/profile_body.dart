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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const _LogOutButton(),
          BlocBuilder<ProfileBloc, ProfileState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              return ProfileForm();
            },
          ),
          const Spacer(),
          const _WalletContainer(),
        ],
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
        onTap: (() {
          context.router.pushNamed(RouteConsts.WALLET_PAGE);
        }),
        leading: _navigateWalletIcon(),
        title: Text(
          "Cüzdanım",
          style: context.textTheme.headline1,
        ),
        subtitle: BlocBuilder<ProfileBloc, ProfileState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            return _balanceRow(context);
          },
        ),
        trailing: _navigateIcon(context),
      ),
    );
  }

  Icon _navigateWalletIcon() {
    return const Icon(
      Icons.account_balance_wallet_outlined,
      size: 32,
    );
  }

  Icon _navigateIcon(BuildContext context) {
    return const Icon(
      Icons.arrow_forward_ios,
      size: 24,
    );
  }

  Row _balanceRow(BuildContext context) {
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
  }
}

class _LogOutButton extends StatelessWidget {
  const _LogOutButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: context.homesymetricPadding,
            child: Text(
              "Profil",
              style: context.textTheme.bodyText1!
                  .copyWith(fontSize: 28, fontWeight: FontWeight.w500),
            ),
          ),
          TextButton.icon(
            onPressed: () => getIt<AuthRepository>().signOut().then((value) =>
                context.router.replaceAll([const AuthControllerRoute()])),
            icon: const Icon(
              Icons.exit_to_app,
            ),
            label: const Text(
              'Çıkış Yap',
            ),
          ),
        ],
      ),
    );
  }
}
