import 'package:flutter/material.dart';
import 'package:hackathon_app/core/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:hackathon_app/core/extensions/context_extension.dart';
import 'package:hackathon_app/core/model/container_model.dart';
import 'package:hackathon_app/view/home/home_page/view/recyclable_progressbar.dart';

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

  Text _supportedConversionsText(BuildContext context) {
    return Text(
      "Desteklenen Dönüşümler:",
      style: context.textTheme.bodyLarge,
      textAlign: TextAlign.start,
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

  ListTile _containerName(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.delete, size: 48),
      title: Text(
        container!.name!,
        style: context.textTheme.headline1,
      ),
    );
  }
}
