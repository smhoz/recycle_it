import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
        const MapWidget(),
      ]),
    );
  }
}

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

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
    const List<LatLng> containers = [
      LatLng(41.0055005, 28.7319907),
      LatLng(41.0042522, 28.8590636),
    ];
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
                containers.length,
                (index) => Marker(
                  markerId: MarkerId("Container #$index"),
                  position: containers[index],
                  infoWindow: InfoWindow(title: "Container #$index"),
                  onTap: () {
                    //TODO: Show Container Info Bottom Sheet
                  },
                ),
              ).toSet(),
              onMapCreated: _onMapCreated,
              initialCameraPosition: //TODO: Implement focus to the nearest container
                  CameraPosition(
                target: containers[0],
                zoom: 15.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
