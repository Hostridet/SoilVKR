
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../route/RouteGenerator.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Soil",
      initialRoute: "/",
      onGenerateRoute: RouteGenerator().generateRoute,
    );
  }
}
