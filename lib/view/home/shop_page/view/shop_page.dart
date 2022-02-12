import 'package:flutter/material.dart';
import 'package:hackathon_app/core/components/center/center_circular_indicator.dart';
import 'package:hackathon_app/core/components/center/center_error.dart';
import 'package:hackathon_app/core/extensions/context_extension.dart';
import 'package:hackathon_app/core/init/theme/color/custom_colors.dart';
import 'package:hackathon_app/core/utils/border/custom_border_radius.dart';

import 'package:provider/provider.dart';

import '../../../../core/components/text/title_text_with_container.dart';
import '../model/shop_item.dart';
import '../viewmodel/shop_view_model.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Consumer<ShopViewModel>(
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
            )
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context, ShopViewModel viewModel) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: context.height * 0.1,
            child: _categoriesList(context, viewModel),
          ),
          SizedBox(
            height: context.height * 0.5,
            child: Padding(
              padding: context.paddingMedium,
              child: _shopLists(viewModel),
            ),
          ),
          TitleTextWithContainer(
            text: "Populer",
            child: SizedBox(
                height: context.height * 0.18, child: _shopLists(viewModel)),
          )
        ],
      ),
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

  ListView _shopLists(ShopViewModel viewModel, {double? width}) {
    List<Item> items = (viewModel
        .itemCategories[viewModel.currentIndex].entities as List<Item>);

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return SizedBox(
          width: width ?? context.width * 0.7,
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: CustomBorderRadius.normalCircular()),
              margin: context.paddingMedium,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    items[index].imageURL.toString(),
                    style: context.textTheme.bodyText1,
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  )
                ],
              )),
        );
      },
    );
  }
}
