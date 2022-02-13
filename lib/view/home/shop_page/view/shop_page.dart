import 'package:flutter/material.dart';
import 'package:hackathon_app/view/home/shop_page/view/buy_item_bottom_sheet.dart';
import '../../../../core/components/center/center_circular_indicator.dart';
import '../../../../core/components/center/center_error.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/init/theme/color/custom_colors.dart';
import '../../../../core/utils/border/custom_border_radius.dart';

import 'package:provider/provider.dart';

import '../../../../core/components/text/title_text_with_container.dart';
import '../model/shop_item.dart';
import '../viewmodel/shop_view_model.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<ShopViewModel>(
              builder: (context, viewModel, child) {
                switch (viewModel.shopState) {
                  case ShopState.loading:
                    return const CenterCircularProgress();
                  case ShopState.complete:
                    return Padding(
                      padding: context.paddingLow,
                      child: _body(context, viewModel),
                    );
                  default:
                    return CenterError(
                      error: viewModel.error,
                    );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context, ShopViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: context.homesymetricPadding,
          child: Text(
            "Mağaza",
            style: context.textTheme.bodyText1!
                .copyWith(fontSize: 28, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: context.height * 0.1,
          child: _categoriesList(context, viewModel),
        ),
        SizedBox(
          height: context.height * 0.5,
          child: _shopLists(viewModel),
        ),
        TitleTextWithContainer(
          text: "Popüler",
          child: SizedBox(
              height: context.height * 0.18, child: _shopLists(viewModel)),
        )
      ],
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
                style: context.textTheme.headline6!.copyWith(
                    color: viewModel.currentIndex == index
                        ? null
                        : context.themeColor.primary),
              ),
            ),
          ),
        );
      },
    );
  }

  BoxDecoration _boxDecoration(
      ShopViewModel viewModel, int index, BuildContext context) {
    bool isEqualCurrentIndex = viewModel.currentIndex == index ? true : false;
    return BoxDecoration(
        border: Border.all(
            color: isEqualCurrentIndex
                ? context.themeColor.primary
                : context.themeColor.onPrimary),
        color: isEqualCurrentIndex
            ? context.themeColor.primary
            : context.themeColor.onPrimary,
        borderRadius: CustomBorderRadius.highCircular(),
        boxShadow: [CustomColors.instance.containerBoxShadow]);
  }

  ListView _shopLists(
    ShopViewModel viewModel,
  ) {
    List<Item> items = (viewModel
        .itemCategories[viewModel.currentIndex].entities as List<Item>);

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
        
      shape: RoundedRectangleBorder(
          borderRadius: CustomBorderRadius.normalCircular()),
      margin: context.paddingMedium,
      child: GestureDetector(
        onTap: () =>
            context.showBottomSheet(child: BuyItemBottomSheet(item: item)),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            _priceRow(context),
            Container(
              alignment: Alignment.bottomLeft,
              margin: context.paddingLow,
              decoration: BoxDecoration(
                borderRadius: CustomBorderRadius.normalCircular(),
                image: DecorationImage(
                  image: NetworkImage(
                    item!.imageURL.toString(),
                  ),
                ),
              ),
              width: context.width * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: context.paddingLow,
                    child: Text(
                      item!.title.toString(),
                      style:
                          context.textTheme.bodyText1!.copyWith(fontSize: 15),
                      maxLines: 2,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
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
        Text("₺${item!.price!.toString()}")
      ]),
    );
  }
}
