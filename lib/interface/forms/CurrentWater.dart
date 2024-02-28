import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:soil/bloc/cur_water_bloc/cur_water_bloc.dart';
import 'package:soil/interface/components/AlertEditingTextWidget.dart';
import 'package:soil/interface/components/InfoLayout.dart';
import 'package:soil/models/ItemWithRoute.dart';
import 'package:soil/models/PointWithRoute.dart';
import 'package:soil/repository/WaterRepository.dart';

class CurrentWaterPage extends StatefulWidget {
  final ItemWithRoute args;
  const CurrentWaterPage({Key? key, required this.args}) : super(key: key);

  @override
  State<CurrentWaterPage> createState() => _CurrentSoilPageState();
}

class _CurrentSoilPageState extends State<CurrentWaterPage> {
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
              Text("Воды"),
            ],
          ),
        ),
        body: RepositoryProvider(
          create: (context) => WaterRepository(),
          child: BlocProvider<CurWaterBloc>(
            create: (context) => CurWaterBloc(RepositoryProvider.of<WaterRepository>(context))..add(CurWaterGetEvent(widget.args.id)),
            child: BlocBuilder<CurWaterBloc, CurWaterState>(
              builder: (context, state) {
                if (state is CurWaterErrorState) {
                  return Center(
                    child: Text(state.error),
                  );
                }
                if (state is CurWaterLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is CurWaterLoadedState) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        FittedBox(child: Image.asset("assets/no-image.jpg")),
                        SizedBox(height: 10),
                        Card(
                          elevation: 1,
                          child: ListTile(
                            title: Text(state.water.name),
                            subtitle: Text("Название"),
                          ),
                        ),
                        Card(
                          elevation: 1,
                          child: ListTile(
                            title: Text(state.water.description),
                            subtitle: Text("Описание"),
                            onTap: () {
                              makeTextDialog(context, 15, state.isAdmin, state.water.description, (value) async {
                                return WaterRepository.updateDescription(widget.args.id, value);
                              }, () {
                                BlocProvider.of<CurWaterBloc>(context).add(CurWaterGetEvent(widget.args.id));
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
        WaterRepository.deleteWater(widget.args.id);
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
