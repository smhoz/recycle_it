import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_app/view/home/home_page/view/home_page.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../core/commons/_print_message.dart';
import '../../../../core/components/appbar/transparent_app_bar.dart';
import '../../../../core/components/button/custom_rounded_button.dart';
import '../../../../core/components/center/center_circular_indicator.dart';
import '../../../../core/components/center/center_error.dart';
import '../../../../core/consts/app/assets_constant.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/network/user_service.dart';
import '../../../../core/repository/global_repositor.dart';
import '../../../../core/utils/locator_get_it.dart';
import '../../_product/widgets/home/title_with_child.dart';
import '../../profile_page/viewmodel/bloc/profile_bloc.dart';
import '../viewmodel/convert_page_viewmodel.dart';

class ConvertPage extends StatelessWidget {
  const ConvertPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TransparentAppBar(),
      body: HeaderTitleWithChild(
        title: "Recycle",
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _animation(context),
            Center(child: _congratulationsText(context)),
            Container(
              color: context.themeColor.primary,
              width: context.width,
              child: Padding(padding: context.paddingMedium, child: _recycleText(context)),
            ),
            _recyclePrice(),
            _convertButton(context),
          ],
        ),
      ),
    );
  }

  Widget _animation(BuildContext context) {
    return SizedBox(
        width: context.width, child: Lottie.asset(AssetConstant.recycleConvertAnimation, height: context.dynamicHeight(0.3), width: context.width));
  }

  Text _congratulationsText(BuildContext context) {
    return Text(
      "CONGRATULATIONS!",
      style: context.textTheme.headline1?.copyWith(color: context.themeColor.primary),
    );
  }

  Text _recycleText(BuildContext context) {
    return Text(
      "Thanks to this recycling, you have given 0.33 m2 of area to the forest!",
      textAlign: TextAlign.center,
      style: context.textTheme.headline4,
    );
  }

  Consumer<ConvertPageViewModel> _recyclePrice() {
    return Consumer<ConvertPageViewModel>(
      builder: (context, viewModel, child) {
        switch (viewModel.convertState) {
          case ConvertState.loading:
            return const CenterCircularProgress();
          case ConvertState.complete:
            return _priceText(context, viewModel);
          default:
            return CenterError(
              error: viewModel.error,
            );
        }
      },
    );
  }

  CustomRoundedButton _convertButton(BuildContext context) {
    return CustomRoundedButton(
      title: 'Convert',
      onTap: () async {
        final _userDBService = UserService();

        final _balance = context.read<ConvertPageViewModel>().conversions.convertedMoneyAmount ?? 0;
        final user = getIt<GlobalRepository>().user;

        var myDouble = double.parse(user?.balance ?? "");
        final result = myDouble + _balance;

        await _userDBService.updateBalance(uid: user?.uid ?? "", balance: result.toString());
        getIt<ProfileBloc>().add(GetProfileUpdatedValues());
        context.router.pushWidget(const HomePage());
        PrintMessage.showSucces(context, message: "Successfully Recycled ${_balance.toString()} is added to your balance.");
      },
    );
  }

  Widget _priceText(BuildContext context, ConvertPageViewModel viewModel) {
    return Container(
      color: context.themeColor.primary,
      width: context.width,
      child: Padding(
        padding: context.paddingMedium,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("${viewModel.conversions.weight} KG", style: context.textTheme.headline4),
            Text("=", style: context.textTheme.headline4),
            Text("${viewModel.conversions.convertedMoneyAmount} \$", style: context.textTheme.headline4),
          ],
        ),
      ),
    );
  }
}
