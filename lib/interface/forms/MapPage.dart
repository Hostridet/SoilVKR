import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/map_bloc/map_bloc.dart';
import '../../models/PointWithRoute.dart';
import '../../repository/MapRepository.dart';
import '../components/Drawer.dart';
import '../components/InfoLayout.dart';


class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
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
                        .pushReplacementNamed('/home/points/one', arguments: PointWithRoute(point: state.point, route: '/home'));
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
                      zoomButtonsBackgroundColor: Colors.blue,
                      zoomButtonsColor: Colors.white,
                      locationButtonBackgroundColor: Colors.blue,
                      locationButtonsColor: Colors.white,
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
                        print(pickedData.address);
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
