import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:flutter/cupertino.dart';
import '../../bloc/map_bloc/map_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/Point.dart';
import '../../repository/MapRepository.dart';

class CurrentLocationPage extends StatefulWidget {
  final Point point;

  const CurrentLocationPage({Key? key, required this.point}) : super(key: key);

  @override
  State<CurrentLocationPage> createState() => _CurrentLocationPageState();
}

class _CurrentLocationPageState extends State<CurrentLocationPage> {
  Future<bool> _onWillPop() async {
    Navigator.of(context)
        .pushReplacementNamed('/home/points');
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: NewGradientAppBar(
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed('/home/points');
                },
                icon: Icon(Icons.arrow_back, size: 35,),
              ),
              Row(
                children: [
                  SizedBox(width: 10,),
                  Text("${widget.point.x.toStringAsFixed(7)} ${widget.point.y.toStringAsFixed(7)}"),
                ],
              ),
            ],
          ),
          gradient: const LinearGradient(
              colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
        ),
        body: RepositoryProvider(
          create: (context) => MapRepository(),
          child: BlocProvider(
            create: (context) => MapBloc(
                RepositoryProvider.of<MapRepository>(context)
            )..add(MapIsAdmin()),
            child: BlocBuilder<MapBloc, MapState>(
                builder: (context, state) {
                  if (state is MapAdminState)
                    return FlutterLocationPicker(
                        showCurrentLocationPointer: false,
                        initPosition: LatLong(widget.point.x, widget.point.y),
                        showSearchBar: false,
                        searchBarBackgroundColor: Colors.white,
                        mapLanguage: 'ru',
                        zoomButtonsBackgroundColor: Colors.blue,
                        zoomButtonsColor: Colors.white,
                        locationButtonBackgroundColor: Colors.blue,
                        locationButtonsColor: Colors.white,
                        showSelectLocationButton: state.isAdmin == true ? true : false,
                        selectLocationButtonText: 'Изменить',
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
                              .add(MapUpdateEvent(widget.point.id, pickedData.address, pickedData.latLong.latitude, pickedData.latLong.longitude));
                          await Future.delayed(const Duration(seconds: 1));
                          Navigator.of(context)
                              .pushReplacementNamed('/home/points');
                        });
                  return Container();
                }
            ),
          ),
        ),
      ),
    );
  }
}
