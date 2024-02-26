import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

import '../../bloc/cur_soil_bloc/cur_soil_bloc.dart';
import '../../models/ItemWithRoute.dart';
import '../../models/PointWithRoute.dart';
import '../../repository/ImageRepository.dart';
import '../../repository/SoilRepository.dart';
import '../components/AlertEditingTextWidget.dart';
import '../components/InfoLayout.dart';

class CurrentSoilPage extends StatefulWidget {
  final ItemWithRoute args;
  const CurrentSoilPage({Key? key, required this.args}) : super(key: key);

  @override
  State<CurrentSoilPage> createState() => _CurrentSoilPageState();
}

class _CurrentSoilPageState extends State<CurrentSoilPage> {
  TextEditingController _controller = TextEditingController();
  Future<bool> _onWillPop() async {
    if (widget.args.point != null) {
      Navigator.of(context).pushReplacementNamed(widget.args.route,
          arguments: PointWithRoute(point: widget.args.point!.point, route: widget.args.point!.route));
    } else {
      Navigator.of(context).pushReplacementNamed(widget.args.route);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                showAlertDialog(context);
              },
              icon: Icon(
                Icons.delete_rounded,
                color: Colors.red,
                size: 30,
              ),
            ),
          ],
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  if (widget.args.point != null) {
                    Navigator.of(context).pushReplacementNamed(widget.args.route,
                        arguments: PointWithRoute(point: widget.args.point!.point, route: widget.args.point!.route));
                  } else {
                    Navigator.of(context).pushReplacementNamed(widget.args.route);
                  }
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 35,
                ),
              ),
              Text("Почва"),
            ],
          ),
        ),
        body: RepositoryProvider(
          create: (context) => SoilRepository(),
          child: BlocProvider<CurSoilBloc>(
            create: (context) => CurSoilBloc(RepositoryProvider.of<SoilRepository>(context))..add(CurSoilGetEvent(widget.args.id)),
            child: BlocBuilder<CurSoilBloc, CurSoilState>(
              builder: (context, state) {
                if (state is CurSoilErrorState) {
                  return Center(
                    child: Text(state.error),
                  );
                }
                if (state is CurSoilLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is CurSoilLoadedState) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await ImageRepository.uploadSoilImage(state.soil.id);
                              },
                              child: SizedBox(
                                width: double.infinity,
                                height: 250,
                                child: FutureBuilder<String>(
                                  future: ImageRepository.getSoilImage(state.soil.id),
                                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                    if (snapshot.hasData) {
                                      return FittedBox(child: Image.memory(base64Decode(snapshot.data!)), fit: BoxFit.fill);
                                    } else {
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
                            title: Text(state.soil.name),
                            subtitle: Text("Название"),
                            onTap: () {
                              makeTextDialog(context, 5, state.isAdmin, state.soil.name, (value) async {
                                return SoilRepository.updateName(widget.args.id, value);
                              }, () {
                                BlocProvider.of<CurSoilBloc>(context).add(CurSoilGetEvent(widget.args.id));
                              });
                            },
                          ),
                        ),
                        Card(
                          elevation: 1,
                          child: ListTile(
                            title: Text(state.soil.description),
                            subtitle: Text("Описание"),
                            onTap: () {
                              makeTextDialog(context, 15, state.isAdmin, state.soil.description, (value) async {
                                return SoilRepository.updateDescription(widget.args.id, value);
                              }, () {
                                BlocProvider.of<CurSoilBloc>(context).add(CurSoilGetEvent(widget.args.id));
                              });
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
                            title: Text(state.soil.acidity != null ? state.soil.acidity!.toString() : "Отсутствует"),
                            subtitle: Text("Кислотность"),
                            onTap: () {
                              makeTextDialog(context, 1, state.isAdmin, state.soil.acidity == null ? "0" : state.soil.acidity!.toString(),
                                  (value) async {
                                return SoilRepository.updateAcidity(widget.args.id, value);
                              }, () {
                                BlocProvider.of<CurSoilBloc>(context).add(CurSoilGetEvent(widget.args.id));
                              });
                            },
                          ),
                        ),
                        Card(
                          elevation: 1,
                          child: ListTile(
                            title: Text(state.soil.minerals != null ? state.soil.minerals! : "Отсутствует"),
                            subtitle: Text("Полезные ископаемые"),
                            onTap: () {
                              makeTextDialog(context, 10, state.isAdmin, state.soil.minerals == null ? "" : state.soil.minerals!,
                                  (value) async {
                                return SoilRepository.updateMinerals(widget.args.id, value);
                              }, () {
                                BlocProvider.of<CurSoilBloc>(context).add(CurSoilGetEvent(widget.args.id));
                              });
                            },
                          ),
                        ),
                        Card(
                          elevation: 1,
                          child: ListTile(
                            title: Text(state.soil.profile != null ? state.soil.profile! : "Отсутствует"),
                            subtitle: Text("Очертание"),
                            onTap: () {
                              makeTextDialog(context, 5, state.isAdmin, state.soil.profile == null ? "" : state.soil.profile!,
                                  (value) async {
                                return SoilRepository.updateProfile(widget.args.id, value);
                              }, () {
                                BlocProvider.of<CurSoilBloc>(context).add(CurSoilGetEvent(widget.args.id));
                              });
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
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Удалить"),
      onPressed: () {
        SoilRepository.deleteSoil(widget.args.id);
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed(widget.args.route);
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
        } else {
          await Future.delayed(const Duration(seconds: 1));
          update();
        }
      } else {
        InfoLayout.buildErrorLayout(context, "Поле не должно быть пустым");
      }
    }
  }
}
