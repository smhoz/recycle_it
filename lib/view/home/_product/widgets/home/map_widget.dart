import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../core/extensions/context_extension.dart';
import 'package:provider/provider.dart';

import '../../../../../core/model/container_model.dart';
import '../../../../../core/components/border/custom_border_radius.dart';
import '../../../home_page/view/container_bottom_sheet.dart';
import '../../../home_page/viewmodel/home_view_model.dart';

class MapWidget extends StatefulWidget {
  final List<RecycleContainer>? containers;
  const MapWidget({Key? key, this.containers}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: context.paddingVeryLow,
        child: Material(
          elevation: 3.0,
          borderRadius: CustomBorderRadius.normalCircular(),
          child: Container(
            height: context.height * 0.65,
            decoration: _boxDecoration(context),
            child: ClipRRect(
              borderRadius: CustomBorderRadius.normalCircular(),
              child: FutureBuilder(
                future: _googleMap(context),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data as Widget;
                  }
                  return Container();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Widget> _googleMap(BuildContext context) async {
    return GoogleMap(
      markers: _markers(context).toSet(),
      initialCameraPosition: //TODO: Implement focus to the nearest container
          CameraPosition(target: widget.containers![0].location!, zoom: 13.0),
    );
  }

  BoxDecoration _boxDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.cardColor,
      borderRadius: CustomBorderRadius.normalCircular(),
    );
  }

  List<Marker> _markers(BuildContext context) {
    return List.generate(
      widget.containers!.length,
      (containerIndex) => Marker(
        //TODO: Put asset image to marker
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        markerId: MarkerId(widget.containers![containerIndex].name!),
        position: widget.containers![containerIndex].location!,
        infoWindow: InfoWindow(title: widget.containers![containerIndex].name!),
        onTap: () {
          context.read<HomeViewModel>().changeIsShowModalBottomSheet(true);
          context.showBottomSheet(
            child: ContainerBottomSheet(
              container: widget.containers![containerIndex],
            ),
            onClosed: () => context.read<HomeViewModel>().changeIsShowModalBottomSheet(false),
          );
        },
      ),
    );
  }
}
