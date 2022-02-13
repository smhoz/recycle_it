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
      initialSize: 0.3,
      maxSize: 0.4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.delete, size: 48),
              title: Text(
                container!.name!,
                style: context.textTheme.headline1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Desteklenen Dönüşümler:",
                style: context.textTheme.bodyLarge,
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                height: 42,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    container!.recyclables!.length,
                    (recyclableIndex) => RecyclableProgressBar(
                      recyclable: container!.recyclables![recyclableIndex],
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.location_pin, size: 32),
              title: Text(
                container!.address!,
                style: context.textTheme.bodyMedium,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.directions),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
