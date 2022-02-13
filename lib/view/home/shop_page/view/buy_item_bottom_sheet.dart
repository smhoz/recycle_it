import 'package:flutter/material.dart';
import 'package:hackathon_app/core/commons/_print_message.dart';
import 'package:hackathon_app/core/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:hackathon_app/core/components/button/custom_rounded_button.dart';
import 'package:hackathon_app/core/extensions/context_extension.dart';
import 'package:hackathon_app/core/network/user_service.dart';
import 'package:hackathon_app/core/repository/global_repositor.dart';
import 'package:hackathon_app/core/utils/locator_get_it.dart';
import 'package:hackathon_app/view/home/profile_page/viewmodel/bloc/profile_bloc.dart';
import 'package:hackathon_app/view/home/shop_page/model/shop_item.dart';

class BuyItemBottomSheet extends StatelessWidget {
  final Item? item;
  const BuyItemBottomSheet({Key? key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      initialSize: 0.4,
      maxSize: 0.5,
      child: Padding(
        padding: context.paddingLow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _itemName(context),
            Padding(
              padding: context.paddingLow,
              child: _supportedConversionsText(context),
            ),
            Padding(
              padding: context.paddingLow,
              child: SizedBox(
                height: context.height * 0.14,
                child: _itemDescription(context),
              ),
            ),
          ],
        ),
      ),
      bottomPinnedChild: _buyButton(context),
    );
  }

  Future<bool> balanceUpdate() async {
    final _userDBService = UserService();
    final _user = getIt<GlobalRepository>().user;
    double _newBalance = double.parse(_user?.balance ?? "0.0") - item!.price!;

    if (_newBalance < 0.0) {
      return false;
    } else {
      bool _result = await _userDBService.updateBalance(
        uid: _user?.uid ?? "",
        balance: _newBalance.toString(),
      );
      getIt<ProfileBloc>().add(GetProfileUpdatedValues());
      return _result;
    }
  }

  Text _itemDescription(BuildContext context) {
    return Text(
      item!.description!,
      style: context.textTheme.bodyMedium,
      textAlign: TextAlign.start,
    );
  }

  Text _supportedConversionsText(BuildContext context) {
    return Text(
      "Açıklama:",
      style: context.textTheme.bodyLarge,
      textAlign: TextAlign.start,
    );
  }

  Widget _buyButton(BuildContext context) {
    return CustomRoundedButton(
      title: "SATIN AL",
      onTap: () {
        Navigator.pop(context);
        balanceUpdate().then((value) {
          if (value) {
            PrintMessage.showSucces(context,
                message:
                    "Satın alım başarılı! Ürün kodunuz e-postanıza gönderilmiştir.");
          } else {
            PrintMessage.showFailed(context,
                message:
                    "Satın alım başarısız! Cüzdanınızda yeterli bakiye olduğundan emin olun.");
          }
        });
      },
    );
  }

  ListTile _itemName(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: context.themeColor.primary,
        child: Image.network(
          item!.imageURL!,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        item!.title!,
        style: context.textTheme.headline1,
      ),
    );
  }
}
