

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soil/interface/components/UserDialog.dart';
import 'package:soil/interface/forms/AddPointPage.dart';
import 'package:soil/interface/forms/CurrentLocationPage.dart';
import 'package:soil/interface/forms/CurrentPlant.dart';
import 'package:soil/interface/forms/CurrentPoint.dart';
import 'package:soil/interface/forms/InfoBook.dart';
import 'package:soil/interface/forms/MapPage.dart';
import 'package:soil/interface/forms/RegisterPage.dart';
import 'package:soil/interface/forms/UserPage.dart';
import 'package:soil/interface/forms/WelcomePage.dart';
import 'package:soil/interface/forms/ZonePage.dart';

import '../interface/components/CurrentItems/AnimalItem.dart';
import '../interface/components/CurrentItems/GroundItem.dart';
import '../interface/components/CurrentItems/PlantItem.dart';
import '../interface/components/CurrentItems/SoilItem.dart';
import '../interface/forms/CurrentAnimal.dart';
import '../interface/forms/CurrentGround.dart';
import '../interface/forms/CurrentSoil.dart';
import '../interface/forms/ErrorPage.dart';
import '../interface/forms/LoginPage.dart';
import '../interface/forms/PointPage.dart';
import '../interface/forms/SettingsPage.dart';
import '../interface/forms/SplashPage.dart';
import '../../models/Point.dart';
import '../models/PointWithRoute.dart';
class RouteGenerator
{



  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/login':
        return CustomPageRoute(
          builder: (context) => const LoginPage(),
        );
      case '/register':
        return CustomPageRoute(
          builder: (context) => const RegisterPage(),
        );
      case '/home':
        return CustomPageRoute(
          builder: (_) => MapPage(),
        );
      case '/':
        return CustomPageRoute(
          builder: (_) => SplashScreen(),
        );
      case '/welcome':
        return CustomPageRoute(
          builder: (_) => WelcomePage(),
        );
      case '/home/user':
        return CustomPageRoute(
          builder: (_) => UserPage(),
        );
      case '/home/points':
        return CustomPageRoute(
          builder: (_) => PointPage(),
        );
      case '/home/points/add':
        return CustomPageRoute(
          builder: (_) => AddPointPage(),
        );
      case '/home/points/map':
        Point point = args as Point;
        return CustomPageRoute(
          builder: (_) => CurrentLocationPage(point: point),
        );
      case '/home/points/one':
        PointWithRoute point = args as PointWithRoute;
        return CustomPageRoute(
          builder: (_) => CurrentPointPage(args: point),
        );
      case '/home/points/plant':
        PointWithRoute point = args as PointWithRoute;
        return CustomPageRoute(
          builder: (_) => PlantItem(args: point),
        );
      case '/home/points/animal':
        PointWithRoute point = args as PointWithRoute;
        return CustomPageRoute(
          builder: (_) => AnimalItem(args: point),
        );
      case '/home/points/soil':
        PointWithRoute point = args as PointWithRoute;
        return CustomPageRoute(
          builder: (_) => SoilItem(args: point),
        );
      case '/home/points/ground':
        PointWithRoute point = args as PointWithRoute;
        return CustomPageRoute(
          builder: (_) => GroundItem(args: point),
        );
      case '/home/book':
        return CustomPageRoute(
          builder: (_) => InfoBook(),
        );
      case '/home/book/plant':
        int id = args as int;
        return CustomPageRoute(
          builder: (_) => CurrentPlantPage(id: args),
        );
      case '/home/book/animal':
        int id = args as int;
        return CustomPageRoute(
          builder: (_) => CurrentAnimalPage(id: args),
        );
      case '/home/book/ground':
        int id = args as int;
        return CustomPageRoute(
          builder: (_) => CurrentGroundPage(id: args),
        );
      case '/home/book/soil':
        int id = args as int;
        return CustomPageRoute(
          builder: (_) => CurrentSoilPage(id: args),
        );
      case '/home/settings':
        return CustomPageRoute(
          builder: (_) => SettingsPage(),
        );
      case '/home/user/edit':
        return CustomPageRoute(
          builder: (_) => FioDialog(),
        );
      case '/home/zone':
        List list = args as List;
        return CustomPageRoute(
          builder: (_) => ZonePage(coords: args),
        );




      // case '/home/reserving':
      //   final args = settings.arguments as CurrentReservationArguments;
      //   return CustomPageRoute(
      //     builder: (context) {
      //       return CurrentWorkPlacePage(
      //         currWorkPlace: args.currWorkPlace,
      //         reservatedTimeList: args.reservatedTimeList,
      //       );
      //     },
      //   );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CustomPageRoute(builder: (_) {
      return ErrorPage();
    });
  }
}

class CustomPageRoute extends MaterialPageRoute {
  CustomPageRoute({builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}