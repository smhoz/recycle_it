import 'package:flutter/material.dart';
import '../../../../core/components/bottom_sheet/custom_bottom_sheet.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/model/container_model.dart';
import '../../_product/widgets/home/recyclable_progressbar.dart';

class ContainerBottomSheet extends StatelessWidget {
  final RecycleContainer? container;
  const ContainerBottomSheet({Key? key, this.container}) : super(key: key);

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
        style: context.textTheme.headline1,
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
      (recyclableIndex) => RecyclableProgressBar(
        recyclable: container!.recyclables![recyclableIndex],
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
        onPressed: () {},
      ),
    );
  }
}
