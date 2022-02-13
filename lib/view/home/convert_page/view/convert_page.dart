import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathon_app/core/commons/_print_message.dart';
import 'package:hackathon_app/core/extensions/context_extension.dart';
import 'package:hackathon_app/core/model/conversion_model.dart';
import 'package:hackathon_app/view/home/convert_page/viewmodel/convert_page_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../../core/components/button/custom_animation_button.dart';
import '../../../../core/components/button/custom_rounded_button.dart';
import '../../../../core/components/center/center_circular_indicator.dart';
import '../../../../core/components/center/center_error.dart';
import '../../../../core/network/user_service.dart';
import '../../../../core/repository/global_repositor.dart';
import '../../../../core/utils/locator_get_it.dart';
import '../../profile_page/viewmodel/bloc/profile_bloc.dart';

class ConvertPage extends StatelessWidget {
  final String? id;
  const ConvertPage({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Divider(
            height: context.height * 0.05,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Text(
                "TEBRİKLER!",
                style: context.textTheme.headline2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Text(
              "Yaptığınız geri dönüşümle \n2 ağacın kesilmesini önlediniz!",
              style: context.textTheme.headline1,
            ),
          ),
          Image.network(
              'https://c.tenor.com/wL0TDpCK8NsAAAAM/recycling-reuse.gif'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 35.0),
            child: SizedBox(
              width: context.width * 0.7,
              child: Consumer<ConvertPageViewModel>(
                builder: (context, viewModel, child) {
                  switch (viewModel.convertState) {
                    case ConvertState.loading:
                      return const CenterCircularProgress();
                    case ConvertState.complete:
                      return _textRow(context, viewModel);
                    default:
                      return CenterError(
                        error: viewModel.error,
                      );
                  }
                },
              ),
            ),
          ),
          CustomRoundedButton(
            title: 'DÖNÜŞTÜR',
            onTap: () async {
              final _userDBService = UserService();

              final _balance = context
                      .read<ConvertPageViewModel>()
                      .conversions
                      .convertedMoneyAmount ??
                  0;
              final user = getIt<GlobalRepository>().user;

              var myDouble = double.parse(user?.balance ?? "");
              final result = myDouble + _balance;

              await _userDBService.updateBalance(
                  uid: user?.uid ?? "", balance: result.toString());
              getIt<ProfileBloc>().add(GetProfileUpdatedValues());

              Navigator.pop(context);
              PrintMessage.showSucces(context,
                  message:
                      "Dönüştürme başarılı. Bakiyenizi cüzdandan kontrol edebilirsiniz.");
            },
          ),
        ],
      ),
    );
  }

  Row _textRow(BuildContext context, ConvertPageViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "${viewModel.conversions.weight} KG",
          style: context.textTheme.headline1,
        ),
        Text(
          "=",
          style: context.textTheme.headline1,
        ),
        Text(
          "${viewModel.conversions.convertedMoneyAmount} ₺",
          style: context.textTheme.headline1,
        ),
      ],
    );
  }
}
