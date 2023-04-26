import 'dart:async';
import 'package:map_picker/map_picker.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:soil/interface/components/Drawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(41.311158, 69.279737),
    zoom: 14.4746,
  );
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: NewGradientAppBar(
        title: const Text('Главный экран'),
        gradient: const LinearGradient(colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          MapPicker(
            // pass icon widget
            //add map picker controller
            mapPickerController: mapPickerController,
            child: GoogleMap(
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              // hide location button
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              //  camera position
              initialCameraPosition: cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onCameraMoveStarted: () {
                // notify map is moving
                mapPickerController.mapMoving!();
                textController.text = "checking ...";
              },
              onCameraMove: (cameraPosition) {
                this.cameraPosition = cameraPosition;
              },
              onCameraIdle: () async {
                // notify map stopped moving
                mapPickerController.mapFinishedMoving!();
                //get address name from camera position
                List<Placemark> placemarks = await placemarkFromCoordinates(
                  cameraPosition.target.latitude,
                  cameraPosition.target.longitude,
                );

                // update the ui with the address
                textController.text =
                '${placemarks.first.name}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).viewPadding.top + 20,
            width: MediaQuery.of(context).size.width - 50,
            height: 50,
            child: TextFormField(
              maxLines: 3,
              textAlign: TextAlign.center,
              readOnly: true,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero, border: InputBorder.none),
              controller: textController,
            ),
          ),
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: SizedBox(
              height: 50,
              child: TextButton(
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    color: Color(0xFFFFFFFF),
                    fontSize: 19,
                    // height: 19/19,
                  ),
                ),
                onPressed: () {
                  print(
                      "Location ${cameraPosition.target.latitude} ${cameraPosition.target.longitude}");
                  print("Address: ${textController.text}");
                },
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xFF32CD32)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
