import 'package:flutter/material.dart';
import '../../../../core/commons/_print_message.dart';
import '../../../../core/components/bottom_sheet/custom_bottom_sheet.dart';
import '../../../../core/components/button/custom_rounded_button.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/network/user_service.dart';
import '../../../../core/repository/global_repositor.dart';
import '../../../../core/utils/locator_get_it.dart';
import '../../profile_page/viewmodel/bloc/profile_bloc.dart';
import '../model/shop_item.dart';

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
                height: context.dynamicHeight(0.14),
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
      return Future.value(false);
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
      "Description:",
      style: context.textTheme.bodyLarge,
      textAlign: TextAlign.start,
    );
  }

  Widget _buyButton(BuildContext context) {
    return CustomRoundedButton(
      title: "BUY",
      onTap: () {
        balanceUpdate().then((value) {
          if (value) {
            PrintMessage.showSucces(context, message: "Satın alım başarılı! Ürün kodunuz e-postanıza gönderilmiştir.");
          } else {
            PrintMessage.showFailed(context, message: "Satın alım başarısız! Cüzdanınızda yeterli bakiye olduğundan emin olun.");
          }
          Navigator.pop(context);
        });
      },
    );
  }

  ListTile _itemName(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(
          item!.imageURL!,
        ),
      ),
      title: Text(
        item!.title!,
        style: context.textTheme.bodyLarge?.copyWith(color: context.themeColor.onSecondary),
      ),
    );
  }
}
