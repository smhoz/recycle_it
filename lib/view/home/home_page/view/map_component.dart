import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackathon_app/core/components/button/custom_rounded_button.dart';
import 'package:hackathon_app/core/extensions/context_extension.dart';
import 'package:hackathon_app/core/model/container_model.dart';
import 'package:hackathon_app/core/model/recyclable_model.dart';
import 'package:hackathon_app/core/utils/border/custom_border_radius.dart';
import 'package:hackathon_app/view/home/convert_page/view/convert_page.dart';
import 'package:hackathon_app/view/home/home_page/view/container_bottom_sheet.dart';
import 'package:hackathon_app/view/home/home_page/viewmodel/home_view_model.dart';
import 'package:hackathon_app/view/home/qr_page/view/qr_component.dart';
import 'package:provider/provider.dart';

class MapComponent extends StatelessWidget {
  const MapComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: context.paddingLow,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _homeTitle(context),
              Consumer<HomeViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.homeViewState == HomeViewState.complete) {
                    return Expanded(
                      child: MapWidget(
                        containers: viewModel.recycleContainers,
                      ),
                    );
                  }
                  return Container();
                },
              ),
              _scanButton(context),
            ]),
      ),
    );
  }

  Padding _homeTitle(BuildContext context) {
    return Padding(
      padding: context.homesymetricPadding,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return ConvertPage();
            },
          ));
        },
        child: Text(
          "Anasayfa",
          style: context.textTheme.bodyText1!
              .copyWith(fontSize: 28, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  CustomRoundedButton _scanButton(BuildContext context) {
    return CustomRoundedButton(
      icon: const Icon(
        Icons.qr_code_scanner,
        color: Colors.white,
      ),
      title: " TARA",
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QRPage(
            onQRCreate: (controller) {},
          ),
        ),
      ),
    );
  }
}

class MapWidget extends StatefulWidget {
  //TODO: Implement list of all containers
  final List<RecycleContainer>? containers;
  const MapWidget({Key? key, this.containers}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Completer<GoogleMapController> _controller = Completer();
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

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
              child: _googleMap(context),
            ),
          ),
        ),
      ),
    );
  }

  GoogleMap _googleMap(BuildContext context) {
    return GoogleMap(
      markers: _markers(context).toSet(),
      onMapCreated: _onMapCreated,
      initialCameraPosition: //TODO: Implement focus to the nearest container
          CameraPosition(
        target: widget.containers![0].location!,
        zoom: 13.0,
      ),
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
          print(widget.containers![containerIndex].toString());
          context.showBottomSheet(
            child: ContainerBottomSheet(
              container: widget.containers![containerIndex],
            ),
          );
        },
      ),
    );
  }
}
