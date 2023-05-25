import 'package:async/async.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../bloc/splash_bloc/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (context) => SplashBloc()..add(SplashLoad()),
      child: BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {
          if (state is SplashLoadedState) {
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.of(context).popAndPushNamed("/welcome");
            });
          }
          if (state is SplashDisabledState) {
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.of(context).popAndPushNamed("/home");
            });
          }
          return Image.asset(
            "assets/splash.png",
            fit: BoxFit.fill,
          );
        },
      ),
    );
  }
}

