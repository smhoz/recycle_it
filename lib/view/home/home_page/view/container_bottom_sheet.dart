import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackathon_app/core/commons/_print_message.dart';
import 'package:hackathon_app/view/home/home_page/viewmodel/container_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/components/bottom_sheet/custom_bottom_sheet.dart';
import '../../../../core/consts/app/app_constant.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/model/container_model.dart';
import '../../_product/widgets/home/recyclable_progressbar.dart';

class ContainerBottomSheet extends StatelessWidget {
  final RecycleContainer? container;
  const ContainerBottomSheet({Key? key, this.container}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      initialSize: 0.5,
      maxSize: 0.7,
      child: Padding(
        padding: context.paddingLow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _containerName(context),
            Padding(
              padding: context.paddingLow,
              child: _supportedConversionsText(context),
            ),
            Padding(
              padding: context.paddingLow,
              child: SizedBox(
                height: context.height * 0.14,
                child: _recyclablesListView(),
              ),
            ),
            _addresListTile(context),
          ],
        ),
      ),
    );
  }

  ListTile _containerName(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 32,
        backgroundColor: context.themeColor.primary,
        child: Icon(
          Icons.delete,
          size: 32,
          color: context.theme.cardColor,
        ),
      ),
      title: Text(
        container!.name!,
        style: context.textTheme.bodyLarge,
      ),
    );
  }

  Text _supportedConversionsText(BuildContext context) {
    return Text(
      "Available Recycles: ",
      style: context.textTheme.bodyLarge,
      textAlign: TextAlign.start,
    );
  }

  ListView _recyclablesListView() {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: _recyclables(),
    );
  }

  List<Widget> _recyclables() {
    return List.generate(
      container!.recyclables!.length,
      (recyclableIndex) => Consumer<ContainerViewModel>(
        builder: (context, viewModel, child) {
          return InkWell(
            onTap: () {
              viewModel.changeTapIndex(recyclableIndex);
            },
            child: Column(
              children: [
                RecyclableProgressBar(
                  recyclable: container!.recyclables![recyclableIndex],
                ),
                AnimatedContainer(
                  duration: context.normalDuration,
                  height: viewModel.tapIndex == recyclableIndex ? 15 : 0,
                  child: Text(
                    "${container!.recyclables![recyclableIndex].currentLoad} / ${container!.recyclables![recyclableIndex].maxLoad} KG",
                    style: context.textTheme.bodyLarge?.copyWith(fontSize: 12),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  ListTile _addresListTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_pin, size: 32),
      title: Text(
        container!.address!,
        style: context.textTheme.bodyMedium,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.directions),
        onPressed: () async {
          if (container?.location != null) {
            await openMap(context, container!.location!);
          }
        },
      ),
    );
  }

  Future<void> openMap(BuildContext context, LatLng location) async {
    String googleUrl = '${AppConstant.googleMapURL}${location.latitude},${location.longitude}';
    if (await launch(googleUrl)) {
      await launch(googleUrl);
    } else {
      PrintMessage.showFailed(context);
    }
  }
}
