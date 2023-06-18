

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cur_ground_bloc/cur_ground_bloc.dart';
import '../../models/ItemWithRoute.dart';
import '../../models/PointWithRoute.dart';
import '../../repository/GroundRepository.dart';
import '../../repository/ImageRepository.dart';
import '../components/AlertEditingTextWidget.dart';
import '../components/InfoLayout.dart';

class CurrentGroundPage extends StatefulWidget {
  final ItemWithRoute args;
  CurrentGroundPage({Key? key, required this.args}) : super(key: key);

  @override
  State<CurrentGroundPage> createState() => _CurrentGroundPageState();
}

class _CurrentGroundPageState extends State<CurrentGroundPage> {
  TextEditingController _controller = TextEditingController();
  Future<bool> _onWillPop() async {
    if (widget.args.point != null) {
      Navigator.of(context)
          .pushReplacementNamed(widget.args.route, arguments: PointWithRoute(point: widget.args.point!.point, route: widget.args.point!.route));
    }
    else {
      Navigator.of(context)
          .pushReplacementNamed(widget.args.route);
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: NewGradientAppBar(
          actions: [
            IconButton(
              onPressed: () async {
                showAlertDialog(context);
              },
              icon: Icon(Icons.delete_rounded, color: Colors.red, size: 30,),
            ),
          ],
          title:  Row(
            children: [
              IconButton(
                onPressed: () {
                  if (widget.args.point != null) {
                    Navigator.of(context)
                        .pushReplacementNamed(widget.args.route, arguments: PointWithRoute(point: widget.args.point!.point, route: widget.args.point!.route));
                  }
                  else {
                    Navigator.of(context)
                        .pushReplacementNamed(widget.args.route);
                  }
                },
                icon: Icon(Icons.arrow_back, size: 35,),
              ),
              Text("Почва"),
            ],
          ),
          gradient: const LinearGradient(colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
        ),
        body: RepositoryProvider(
          create: (context) => GroundRepository(),
          child: BlocProvider<CurGroundBloc>(
            create: (context) => CurGroundBloc(
                RepositoryProvider.of<GroundRepository>(context)
            )..add(CurGroundGetEvent(widget.args.id)),
            child: BlocBuilder<CurGroundBloc, CurGroundState>(
              builder: (context, state) {
                if (state is CurGroundLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is CurGroundErrorState) {
                  return Center(
                    child: Text(state.error),
                  );
                }
                if (state is CurGroundLoadedState) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (state.isAdmin && widget.args.route == "/home/book") {
                                  await ImageRepository.uploadGroundImage(state.ground.id);
                                }
                              },
                              child: SizedBox(
                                width: double.infinity,
                                height: 250,
                                child: FutureBuilder<String>(
                                  future: ImageRepository.getGroundImage(state.ground.id),
                                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                    if (snapshot.hasData) {
                                      return FittedBox(child: Image.memory(base64Decode(snapshot.data!)), fit: BoxFit.fill);
                                    }
                                    else {
                                      return FittedBox(child: Image.asset("assets/no-image.jpg"), fit: BoxFit.fill);

                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Card(
                          elevation: 1,
                          child: ListTile(
                            title: Text(state.ground.name),
                            subtitle: Text("Название"),
                            onTap: () {
                              makeTextDialog(context, 1, state.isAdmin, state.ground.name, (value) async {return GroundRepository.updateName(widget.args.id, value);},
                                      () { BlocProvider.of<CurGroundBloc>(context).add(CurGroundGetEvent(widget.args.id));});
                            },
                          ),
                        ),
                        Card(
                          elevation: 1,
                          child: ListTile(
                            title: Text(state.ground.description),
                            subtitle: Text("Описание"),
                            onTap: () {
                              makeTextDialog(context, 15, state.isAdmin, state.ground.description, (value) async {return GroundRepository.updateDescription(widget.args.id, value);},
                                      () { BlocProvider.of<CurGroundBloc>(context).add(CurGroundGetEvent(widget.args.id));});
                            },
                          ),
                        ),
                        // Card(
                        //   elevation: 1,
                        //   child: ListTile(
                        //     title: Text(
                        //         state.plant.isFodder != null
                        //             ? state.plant.isFodder == 0 ? "Нет" : "Да"
                        //             : "Отсутствует"
                        //     ),
                        //     subtitle: Text("Является кормовым"),
                        //   ),
                        // ),

                        Card(
                          elevation: 1,
                          child: ListTile(
                            title: Text(
                                state.ground.density != null
                                    ? state.ground.density!.toString()
                                    : "Отсутствует"
                            ),
                            subtitle: Text("Плотность"),
                            onTap: () {
                              makeTextDialog(context, 1, state.isAdmin, state.ground.density == null ? "0" : state.ground.density!.toString(), (value) async {return GroundRepository.updateDensity(widget.args.id, value);},
                                      () { BlocProvider.of<CurGroundBloc>(context).add(CurGroundGetEvent(widget.args.id));});
                            },
                          ),
                        ),
                        Card(
                          elevation: 1,
                          child: ListTile(
                            title: Text(
                                state.ground.humidity != null
                                    ? state.ground.humidity!.toString()
                                    : "Отсутствует"
                            ),
                            subtitle: Text("Влажность"),
                            onTap: () {
                              makeTextDialog(context, 1, state.isAdmin, state.ground.humidity == null ? "0" : state.ground.humidity!.toString(), (value) async {return GroundRepository.updateHumidity(widget.args.id, value);},
                                      () { BlocProvider.of<CurGroundBloc>(context).add(CurGroundGetEvent(widget.args.id));});
                            },
                          ),
                        ),
                        Card(
                          elevation: 1,
                          child: ListTile(
                            title: Text(
                                state.ground.moos != null
                                    ? state.ground.moos!.toString()
                                    : "Отсутствует"
                            ),
                            subtitle: Text("Твёрдость грунта по шкале Мооса"),
                            onTap: () {
                              makeTextDialog(context, 1, state.isAdmin, state.ground.moos == null ? "0" : state.ground.moos!.toString(), (value) async {return GroundRepository.updateMoos(widget.args.id, value);},
                                      () { BlocProvider.of<CurGroundBloc>(context).add(CurGroundGetEvent(widget.args.id));});
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("Отмена"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Удалить"),
      onPressed:  () {
        GroundRepository.deleteGround(widget.args.id);
        Navigator.of(context).pop();
        Navigator.of(context)
            .pushReplacementNamed(widget.args.route);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Внимание"),
      content: Text("Вы точно хотите удалить?"),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            cancelButton,
            continueButton,
          ],
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  Future<void> makeTextDialog(BuildContext context, int maxLine, bool isAdmin, String text, Function request, Function update) async {
    if (isAdmin && widget.args.route == "/home/book") {
      _controller.text = text;
      String? value = await showDialog(
        context: context,
        builder: (context) => AlertEditingTextWidget.AlertEditingText(context, maxLine, _controller),
      );
      if (value != null) {
        int statusCode = await request(value);
        if (statusCode != 200) {
          InfoLayout.buildErrorLayout(context, "Не удалось обновить данные");
        }
        else {
          await Future.delayed(const Duration(seconds: 1));
          update();
        }
      }
    }
  }
}
