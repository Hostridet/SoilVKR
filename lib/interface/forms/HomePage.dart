import 'dart:async';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:soil/interface/components/Drawer.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:flutter/foundation.dart';
import 'package:soil/interface/components/InfoLayout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/map_bloc/map_bloc.dart';
import '../../repository/MapRepository.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: NewGradientAppBar(
        title: const Text('Главный экран'),
        gradient: const LinearGradient(colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
      ),
      body: RepositoryProvider(
        create: (context) => MapRepository(),
        child: BlocProvider<MapBloc>(
          create: (context) => MapBloc(
              RepositoryProvider.of<MapRepository>(context)
          ),
          child: BlocConsumer<MapBloc, MapState>(
              listener: (context, state) {
                if (state is MapErrorState) {
                  final snackBar = SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.only(bottom: 560),
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Ошибка',
                      message: state.error,
                      contentType: ContentType.warning,
                    ),
                  );

                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
                }
                if (state is MapSuccessState) {
                  Navigator.of(context)
                      .pushReplacementNamed('/home/zone', arguments: [state.long, state.lat]);
                }
              },
              builder: (context, state) {
                return FlutterLocationPicker(
                    showCurrentLocationPointer: false,
                    initPosition: LatLong(43.10562, 131.87353),
                    showSearchBar: false,
                    searchBarBackgroundColor: Colors.white,
                    mapLanguage: 'ru',
                    selectLocationButtonText: 'Выбрать',
                    selectLocationButtonStyle: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                    initZoom: 11,
                    minZoomLevel: 5,
                    maxZoomLevel: 16,
                    trackMyPosition: false,
                    onError: (e) {
                      InfoLayout.buildErrorLayout(context, e.toString());
                    },
                    onPicked: (pickedData) {
                      BlocProvider.of<MapBloc>(context)
                          .add(MapGetEvent(pickedData.latLong.latitude, pickedData.latLong.longitude));
                    });
              }
          ),
        ),
      )
    );
  }
}
