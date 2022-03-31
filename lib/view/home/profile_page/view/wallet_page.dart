import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_app/view/home/_product/widgets/home/title_with_child.dart';
import '../../../../core/components/appbar/transparent_app_bar.dart';
import '../../../../core/components/button/custom_rounded_button.dart';
import '../../../../core/components/text/input_field.dart';
import '../../../../core/components/text/title_text_with_container.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/utils/locator_get_it.dart';
import 'wallet_form.dart';

import '../../_product/widgets/profile/alert_dialog.dart';
import '../viewmodel/cubit/balance_cubit.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _cubit = getIt<BalanceCubit>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const TransparentAppBar(),
      body: BlocProvider(
        create: (context) => _cubit,
        child: HeaderTitleWithChild(
          title: "Add Balance",
          child: _scaffoldBody(context, _cubit),
        ),
      ),
    );
  }

  Widget _scaffoldBody(BuildContext context, BalanceCubit _cubit) {
    return Padding(
      padding: context.paddingVerticalMedium,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [const WalletForm(), _incrementAndDecrementButton(context, _cubit), _submitButton(context)],
        ),
      ),
    );
  }

  CustomRoundedButton _submitButton(BuildContext context) {
    return CustomRoundedButton(onTap: () => WalletAlertDialog.showMyDialog(context), title: "Submit");
  }

  InputField _incrementAndDecrementButton(BuildContext context, BalanceCubit _cubit) {
    return InputField(
      textStyle: context.textTheme.bodyText1,
      textAlign: TextAlign.center,
      controller: _cubit.balanceController,
      textInputType: TextInputType.number,
      suffix: _incrementButton(_cubit),
      icon: _decrementButton(_cubit),
    );
  }

  IconButton _decrementButton(BalanceCubit _cubit) {
    return IconButton(onPressed: _cubit.balanceDecrement, icon: const Icon(Icons.remove));
  }

  IconButton _incrementButton(BalanceCubit _cubit) {
    return IconButton(onPressed: _cubit.balanceIncrement, icon: const Icon(Icons.add));
  }
}
