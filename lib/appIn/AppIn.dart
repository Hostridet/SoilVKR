import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/theme_bloc/theme_bloc.dart';
import '../route/RouteGenerator.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (context) =>
      ThemeBloc()
        ..add(ThemeCheckEvent()),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          if (state is ThemeDarkState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData.dark(),
              initialRoute: "/",
              onGenerateRoute: RouteGenerator().generateRoute,
            );
          }
          if (state is ThemeWhiteState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              initialRoute: "/",
              onGenerateRoute: RouteGenerator().generateRoute,
            );
          }
          return Container();
        },
      ),
    );
  }
}
