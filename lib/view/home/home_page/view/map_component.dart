import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/model/container_model.dart';
import '../../../../core/components/bottom_sheet/custom_bottom_sheet.dart';

class MapComponent extends StatelessWidget {
  const MapComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text(
          'Map Component',
          style: Theme.of(context).textTheme.headline3,
        ),
        MapWidget(containers: [
          RecycleContainer(
            name: "Container 1",
            location: const LatLng(41.0055005, 28.7319907),
            recyclables: [],
          )
        ]),
      ]),
    );
  }
}

class MapWidget extends StatefulWidget {
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
    //TODO: Implement list of all locations
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        elevation: 3.0,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: GoogleMap(
              markers: List.generate(
                widget.containers!.length,
                (index) => Marker(
                  markerId: MarkerId(widget.containers![index].name!),
                  position: widget.containers![index].location!,
                  infoWindow:
                      InfoWindow(title: widget.containers![index].name!),
                  onTap: () {
                    context.showBottomSheet(
                      child: CustomBottomSheet(
                        initialSize: 0.25,
                        maxSize: 0.5,
                        child: Text(widget.containers![index].name!),
                      ),
                    );
                  },
                ),
              ).toSet(),
              onMapCreated: _onMapCreated,
              initialCameraPosition: //TODO: Implement focus to the nearest container
                  CameraPosition(
                target: widget.containers![0].location!,
                zoom: 15.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
