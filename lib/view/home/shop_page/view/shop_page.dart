import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/components/border/custom_border_radius.dart';
import '../../../../core/components/center/center_circular_indicator.dart';
import '../../../../core/components/center/center_error.dart';
import '../../../../core/components/text/title_text_with_container.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/init/theme/color/custom_colors.dart';
import '../../_product/widgets/home/title_with_child.dart';
import '../model/shop_item.dart';
import '../viewmodel/shop_view_model.dart';
import 'buy_item_bottom_sheet.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<ShopViewModel>(
        builder: (context, viewModel, child) {
          switch (viewModel.shopState) {
            case ShopState.loading:
              return const CenterCircularProgress();
            case ShopState.complete:
              return _body(context, viewModel);
            default:
              return CenterError(
                error: viewModel.error,
              );
          }
        },
      ),
    );
  }

  Widget _body(BuildContext context, ShopViewModel viewModel) {
    return HeaderTitleWithChild(
      title: "Store",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: context.dynamicHeight(0.1),
            child: _categoriesList(context, viewModel),
          ),
          SizedBox(
            height: context.dynamicHeight(0.58),
            child: SingleChildScrollView(
              child: Column(
                children: [_shopListContainer(context, viewModel), _popularListContainer(context, viewModel)],
              ),
            ),
          )
        ],
      ),
    );
  }

  TitleTextWithContainer _popularListContainer(BuildContext context, ShopViewModel viewModel) {
    return TitleTextWithContainer(
      text: "Popular",
      child: SizedBox(height: context.dynamicHeight(0.18), child: _shopLists(viewModel)),
    );
  }

  SizedBox _shopListContainer(BuildContext context, ShopViewModel viewModel) {
    return SizedBox(
      height: context.dynamicHeight(0.5),
      child: _shopLists(viewModel),
    );
  }

  ListView _categoriesList(BuildContext context, ShopViewModel viewModel) {
    return ListView.builder(
      shrinkWrap: true,
      padding: context.paddingMedium,
      scrollDirection: Axis.horizontal,
      itemCount: viewModel.itemCategories.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            viewModel.changeIndex(index);
          },
          child: Padding(
            padding: context.paddingHorizontalMedium,
            child: AnimatedContainer(
              duration: context.normalDuration,
              padding: context.symetricPadding,
              alignment: Alignment.center,
              decoration: _boxDecoration(viewModel, index, context),
              child: Text(
                viewModel.itemCategories[index].categoryName!,
                style: context.textTheme.headline6?.copyWith(color: viewModel.currentIndex == index ? null : context.themeColor.primary),
              ),
            ),
          ),
        );
      },
    );
  }

  BoxDecoration _boxDecoration(ShopViewModel viewModel, int index, BuildContext context) {
    bool isEqualCurrentIndex = viewModel.currentIndex == index ? true : false;
    return BoxDecoration(
        border: Border.all(color: isEqualCurrentIndex ? context.themeColor.primary : context.themeColor.onPrimary),
        color: isEqualCurrentIndex ? context.themeColor.primary : context.themeColor.onPrimary,
        borderRadius: CustomBorderRadius.highCircular(),
        boxShadow: [CustomColors.instance.containerBoxShadow]);
  }

  ListView _shopLists(
    ShopViewModel viewModel,
  ) {
    List<Item> items = (viewModel.itemCategories[viewModel.currentIndex].entities as List<Item>);

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ItemCard(item: items[index]);
      },
    );
  }
}

class ItemCard extends StatelessWidget {
  final Item? item;
  const ItemCard({Key? key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: CustomBorderRadius.normalCircular()),
      margin: context.paddingMedium,
      child: GestureDetector(
        onTap: () => context.showBottomSheet(child: BuyItemBottomSheet(item: item)),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            _priceRow(context),
            _shopContainer(context),
          ],
        ),
      ),
    );
  }

  Container _shopContainer(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      margin: context.paddingLow,
      decoration: _boxDecoration(),
      width: context.dynamicWidth(0.7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: context.paddingLow,
            child: _title(context),
          ),
          _forwardIcon()
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      borderRadius: CustomBorderRadius.normalCircular(),
      image: DecorationImage(
        image: NetworkImage(
          item!.imageURL.toString(),
        ),
      ),
    );
  }

  Icon _forwardIcon() {
    return const Icon(
      Icons.arrow_forward_ios,
      color: Colors.black,
    );
  }

  Text _title(BuildContext context) {
    return Text(
      item!.title.toString(),
      style: context.textTheme.bodyText1?.copyWith(fontSize: 15),
      maxLines: 2,
    );
  }

  Widget _priceRow(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Icon(
          Icons.circle,
          color: CustomColors.instance.coinColor,
          size: 24,
        ),
        SizedBox(
          width: context.width * 0.02,
        ),
        Text("₺${item?.price?.toString()}")
      ]),
    );
  }
}
