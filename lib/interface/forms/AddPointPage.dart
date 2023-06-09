import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

import '../../bloc/map_bloc/map_bloc.dart';
import '../../repository/MapRepository.dart';

class AddPointPage extends StatefulWidget {
  final String route;
  const AddPointPage({Key? key, required this.route}) : super(key: key);

  @override
  State<AddPointPage> createState() => _AddPointPageState();
}

class _AddPointPageState extends State<AddPointPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(widget.route);
              },
              icon: Icon(Icons.arrow_back, size: 35,),
            ),
            Row(
              children: [
                SizedBox(width: 10,),
                Text("Добаить территорию"),
              ],
            ),
          ],
        ),
        gradient: const LinearGradient(
            colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
      ),
      body: RepositoryProvider(
        create: (context) => MapRepository(),
        child: BlocProvider<MapBloc>(
          create: (context) =>
              MapBloc(
                  RepositoryProvider.of<MapRepository>(context)
              ),
          child: BlocBuilder<MapBloc, MapState>(
            builder: (context, state) {
              return FlutterLocationPicker(
                  showCurrentLocationPointer: false,
                  initPosition: LatLong(43.10562, 131.87353),
                  showSearchBar: false,
                  searchBarBackgroundColor: Colors.white,
                  mapLanguage: 'ru',
                  zoomButtonsBackgroundColor: Colors.blue,
                  zoomButtonsColor: Colors.white,
                  locationButtonBackgroundColor: Colors.blue,
                  locationButtonsColor: Colors.white,
                  selectLocationButtonText: 'Добавить',
                  selectLocationButtonStyle: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  initZoom: 11,
                  minZoomLevel: 5,
                  maxZoomLevel: 16,
                  trackMyPosition: false,
                  onError: (e) {},
                  onPicked: (pickedData) async {
                    BlocProvider.of<MapBloc>(context)
                        .add(MapAddEvent(pickedData.latLong.latitude, pickedData.latLong.longitude, pickedData.address));
                    await Future.delayed(const Duration(seconds: 1));
                    Navigator.of(context)
                        .pushReplacementNamed('/home/points');
                  });
            },
          ),
        ),
      ),
    );
  }
}
