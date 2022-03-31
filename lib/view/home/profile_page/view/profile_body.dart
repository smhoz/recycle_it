import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/model/user_model.dart';
import '../../_product/widgets/home/title_with_child.dart';
import '../../../../core/consts/navigation_const.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/init/theme/color/custom_colors.dart';
import '../../../../core/navigation/navigation_manager.gr.dart';
import '../../../../core/repository/auth_repository.dart';
import '../../../../core/repository/global_repositor.dart';
import '../../../../core/components/border/custom_border_radius.dart';

import '../../../../../../core/utils/locator_get_it.dart';
import '../viewmodel/bloc/profile_bloc.dart';
import '../viewmodel/cubit/profileform_cubit.dart';
import 'profile_form.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: HeaderTitleWithChild(
        trailing: _settingsButton(context),
        title: "Profil",
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: SizedBox(
                height: context.dynamicHeight(0.3),
                width: context.dynamicWidth(0.9),
                child: _profilAvatar(context),
              ),
            ),
            const Spacer(),
            _profileForm(),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _settingsButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () => getIt<AuthRepository>().signOut().then((value) => context.router.replaceAll([const AuthControllerRoute()])),
    );
  }

  Stack _profilAvatar(BuildContext context) {
    User user = ProfileformCubit().user;
    return Stack(
      children: [
        Center(
          child: SizedBox(
            height: context.dynamicHeight(0.25),
            width: context.dynamicWidth(0.9),
            child: Material(
              borderRadius: const CustomBorderRadius.onlyTopLeftAndRightNormalCircular(),
              elevation: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 3),
                  Text(("${user.name} ${user.surname}"), style: context.textTheme.bodyLarge),
                  const Spacer(flex: 1),
                  const _WalletContainer()
                ],
              ),
            ),
          ),
        ),
        _avatar(context)
      ],
    );
  }

  Align _avatar(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Material(
        elevation: 8,
        color: CustomColors.instance.coinColor,
        child: CircleAvatar(
          radius: 44,
          backgroundColor: context.themeColor.primary,
        ),
        type: MaterialType.circle,
      ),
    );
  }

  BlocBuilder<ProfileBloc, ProfileState> _profileForm() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return Expanded(flex: 6, child: ProfileForm());
      },
    );
  }
}

class _WalletContainer extends StatelessWidget {
  const _WalletContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _boxDecoration(context),
      child: ListTile(
        onTap: () => context.router.pushNamed(RouteConsts.WALLET_PAGE),
        leading: _navigateWalletIcon(),
        title: Text("Balance", style: context.textTheme.headline2),
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

  BoxDecoration _boxDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.themeColor.primary,
    );
  }

  Icon _navigateWalletIcon() {
    return const Icon(
      Icons.account_balance_wallet_outlined,
      size: 32,
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
        width: context.dynamicWidth(0.02),
      ),
      Text("\$${((getIt<GlobalRepository>().user?.balance) ?? 0).toString()}")
    ]);
  }
}

Icon _navigateIcon(BuildContext context) {
  return const Icon(
    Icons.arrow_forward_ios,
    size: 24,
  );
}
