import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackathon_app/core/components/button/custom_rounded_button.dart';
import 'package:hackathon_app/core/extensions/context_extension.dart';
import 'package:hackathon_app/core/model/container_model.dart';
import 'package:hackathon_app/core/model/recyclable_model.dart';
import 'package:hackathon_app/view/home/home_page/view/container_bottom_sheet.dart';
import 'package:hackathon_app/view/home/qr_page/view/qr_component.dart';

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
        MapWidget(
          containers: [
            RecycleContainer(
              name: "Container 1",
              address:
                  "Çankaya Mh., Veli Bacık Cd., No: 9/3, Küçükçekmece/İstanbul",
              location: const LatLng(41.0255005, 28.7319907),
              recyclables: [
                Recyclable(
                  type: RecyclableType.paper,
                  currentLoad: 24,
                  maxLoad: 60,
                ),
                Recyclable(
                  type: RecyclableType.plastic,
                  currentLoad: 46,
                  maxLoad: 72,
                ),
                Recyclable(
                  type: RecyclableType.oil,
                  currentLoad: 12,
                  maxLoad: 50,
                ),
                Recyclable(
                  type: RecyclableType.glass,
                  currentLoad: 8,
                  maxLoad: 36,
                ),
              ],
            ),
            RecycleContainer(
              name: "Container 2",
              address: "Gültepe Mah., Blabla Sokak, No: 13, Kadıköy/İstanbul",
              location: const LatLng(41.0285005, 28.7589907),
              recyclables: [
                Recyclable(
                  type: RecyclableType.battery,
                  currentLoad: 24,
                  maxLoad: 60,
                ),
              ],
            ),
          ],
        ),
        CustomRoundedButton(
          icon: const Icon(
            Icons.qr_code_scanner,
            color: Colors.white,
          ),
          title: "SCAN",
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QRPage(
                onQRCreate: (controller) {},
              ),
            ),
          ),
        ),
      ]),
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
                (containerIndex) => Marker(
                  //TODO: Put asset image to marker
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueViolet),
                  markerId: MarkerId(widget.containers![containerIndex].name!),
                  position: widget.containers![containerIndex].location!,
                  infoWindow: InfoWindow(
                      title: widget.containers![containerIndex].name!),
                  onTap: () {
                    context.showBottomSheet(
                      child: ContainerBottomSheet(
                        container: widget.containers![containerIndex],
                      ),
                    );
                  },
                ),
              ).toSet(),
              onMapCreated: _onMapCreated,
              initialCameraPosition: //TODO: Implement focus to the nearest container
                  CameraPosition(
                target: widget.containers![0].location!,
                zoom: 13.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
