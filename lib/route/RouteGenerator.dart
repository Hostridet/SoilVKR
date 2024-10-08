import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soil/interface/components/AddItems/AddConAnimal.dart';
import 'package:soil/interface/components/AddItems/AddConClimat.dart';
import 'package:soil/interface/components/AddItems/AddConFoundation.dart';
import 'package:soil/interface/components/AddItems/AddConGround.dart';
import 'package:soil/interface/components/AddItems/AddConPlant.dart';
import 'package:soil/interface/components/AddItems/AddConPoint.dart';
import 'package:soil/interface/components/AddItems/AddConRelief.dart';
import 'package:soil/interface/components/AddItems/AddConWater.dart';
import 'package:soil/interface/components/CurrentItems/ClimatPoint.dart';
import 'package:soil/interface/components/CurrentItems/FoundationPoint.dart';
import 'package:soil/interface/components/CurrentItems/ReliefPoint.dart';
import 'package:soil/interface/components/CurrentItems/WaterPoint.dart';
import 'package:soil/interface/components/UserDialog.dart';
import 'package:soil/interface/forms/AddPointPage.dart';
import 'package:soil/interface/forms/AdminPages/AdminPage.dart';
import 'package:soil/interface/forms/AdminPages/EditUserPage.dart';
import 'package:soil/interface/forms/AdminPages/LocatinSoilCon.dart';
import 'package:soil/interface/forms/AdminPages/LocationClimatCon.dart';
import 'package:soil/interface/forms/AdminPages/LocationFoundationCon.dart';
import 'package:soil/interface/forms/AdminPages/LocationReliefCon.dart';
import 'package:soil/interface/forms/AdminPages/LocationWaterCon.dart';
import 'package:soil/interface/forms/AdminPages/PlantAnimalCon.dart';
import 'package:soil/interface/forms/AdminPages/SoilGroundCon.dart';
import 'package:soil/interface/forms/AdminPages/SoilPlantCon.dart';
import 'package:soil/interface/forms/CurrentClimat.dart';
import 'package:soil/interface/forms/CurrentFoundation.dart';
import 'package:soil/interface/forms/CurrentLocationPage.dart';
import 'package:soil/interface/forms/CurrentPlant.dart';
import 'package:soil/interface/forms/CurrentPoint.dart';
import 'package:soil/interface/forms/CurrentRelief.dart';
import 'package:soil/interface/forms/CurrentWater.dart';
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
import '../interface/forms/AdminPages/AllUserPage.dart';
import '../interface/forms/CurrentAnimal.dart';
import '../interface/forms/CurrentGround.dart';
import '../interface/forms/CurrentSoil.dart';
import '../interface/forms/ErrorPage.dart';
import '../interface/forms/LoginPage.dart';
import '../interface/forms/PointPage.dart';
import '../interface/forms/SettingsPage.dart';
import '../interface/forms/SplashPage.dart';
import '../../models/Point.dart';
import '../models/ItemWithRoute.dart';
import '../models/PointWithRoute.dart';

class RouteGenerator {
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
      case '/home/user/all':
        return CustomPageRoute(
          builder: (_) => AllUserPage(),
        );
      case '/home/points':
        return CustomPageRoute(
          builder: (_) => PointPage(),
        );
      case '/home/points/add':
        String route = args as String;
        return CustomPageRoute(
          builder: (_) => AddPointPage(route: route),
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
      case '/home/points/relief':
        PointWithRoute point = args as PointWithRoute;
        return CustomPageRoute(
          builder: (_) => ReliefItem(args: point),
        );
      case '/home/points/water':
        PointWithRoute point = args as PointWithRoute;
        return CustomPageRoute(
          builder: (_) => WaterItem(args: point),
        );
      case '/home/points/foundation':
        PointWithRoute point = args as PointWithRoute;
        return CustomPageRoute(
          builder: (_) => FoundationItem(args: point),
        );
      case '/home/points/climat':
        PointWithRoute point = args as PointWithRoute;
        return CustomPageRoute(
          builder: (_) => ClimatItem(args: point),
        );
      case '/home/book':
        return CustomPageRoute(
          builder: (_) => InfoBook(),
        );
      case '/home/book/plant':
        ItemWithRoute id = args as ItemWithRoute;
        return CustomPageRoute(
          builder: (_) => CurrentPlantPage(args: id),
        );
      case '/home/book/animal':
        ItemWithRoute id = args as ItemWithRoute;
        return CustomPageRoute(
          builder: (_) => CurrentAnimalPage(args: id),
        );
      case '/home/book/ground':
        ItemWithRoute id = args as ItemWithRoute;
        return CustomPageRoute(
          builder: (_) => CurrentGroundPage(args: id),
        );
      case '/home/book/soil':
        ItemWithRoute id = args as ItemWithRoute;
        return CustomPageRoute(
          builder: (_) => CurrentSoilPage(args: id),
        );
      case '/home/book/foundation':
        ItemWithRoute id = args as ItemWithRoute;
        return CustomPageRoute(
          builder: (_) => CurrentFoundationPage(args: id),
        );
      case '/home/book/water':
        ItemWithRoute id = args as ItemWithRoute;
        return CustomPageRoute(
          builder: (_) => CurrentWaterPage(args: id),
        );
      case '/home/book/climat':
        ItemWithRoute id = args as ItemWithRoute;
        return CustomPageRoute(
          builder: (_) => CurrentClimatPage(args: id),
        );
      case '/home/book/relief':
        ItemWithRoute id = args as ItemWithRoute;
        return CustomPageRoute(
          builder: (_) => CurrentReliefPage(args: id),
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
      case '/home/admin':
        return CustomPageRoute(
          builder: (_) => AdminPage(),
        );
      case '/home/admin/soilground':
        return CustomPageRoute(
          builder: (_) => SoilGroundCon(),
        );
      case '/home/admin/soilplant':
        return CustomPageRoute(
          builder: (_) => SOilPlantCon(),
        );
      case '/home/admin/plantanimal':
        return CustomPageRoute(
          builder: (_) => PlantAnimalCon(),
        );
      case '/home/admin/locationsoil':
        return CustomPageRoute(
          builder: (_) => LocationSoilCon(),
        );
      case '/home/admin/locationwater':
        return CustomPageRoute(
          builder: (_) => LocationWaterCon(),
        );
      case '/home/admin/locationrelief':
        return CustomPageRoute(
          builder: (_) => LocationReliefCon(),
        );
      case '/home/admin/locationfoundation':
        return CustomPageRoute(
          builder: (_) => LocationFoundationCon(),
        );
      case '/home/admin/locationclimat':
        return CustomPageRoute(
          builder: (_) => LocationClimatCon(),
        );
      case '/home/admin/soilground/add':
        return CustomPageRoute(
          builder: (_) => AddConGround(),
        );
      case '/home/admin/plantanimal/add':
        return CustomPageRoute(
          builder: (_) => AddConAnimal(),
        );
      case '/home/admin/soilplant/add':
        return CustomPageRoute(
          builder: (_) => AddConPlant(),
        );
      case '/home/admin/locationsoil/add':
        return CustomPageRoute(
          builder: (_) => AddConPoint(),
        );
      case '/home/admin/locationwater/add':
        return CustomPageRoute(
          builder: (_) => AddConWater(),
        );
      case '/home/admin/locationclimat/add':
        return CustomPageRoute(
          builder: (_) => AddConClimat(),
        );
      case '/home/admin/locationrelief/add':
        return CustomPageRoute(
          builder: (_) => AddConRelief(),
        );
      case '/home/admin/locationfoundation/add':
        return CustomPageRoute(
          builder: (_) => AddConFoundation(),
        );
      case '/home/admin/users/edit':
        int id = args as int;
        return CustomPageRoute(
          builder: (_) => EditUserPage(id: id),
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
