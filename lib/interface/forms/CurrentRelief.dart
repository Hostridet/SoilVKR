import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soil/bloc/cur_foundation_bloc/cur_foundation_bloc.dart';
import 'package:soil/bloc/cur_relief_bloc/cur_relief_bloc.dart';
import 'package:soil/interface/components/AlertEditingTextWidget.dart';
import 'package:soil/interface/components/AlertEditingWidget.dart';
import 'package:soil/interface/components/InfoLayout.dart';
import 'dart:convert';

import 'package:soil/models/ItemWithRoute.dart';
import 'package:soil/models/PointWithRoute.dart';
import 'package:soil/repository/ImageRepository.dart';
import 'package:soil/repository/ReliefRepository.dart';

class CurrentReliefPage extends StatefulWidget {
  final ItemWithRoute args;
  const CurrentReliefPage({Key? key, required this.args}) : super(key: key);

  @override
  State<CurrentReliefPage> createState() => _CurrentAnimalPageState();
}

class _CurrentAnimalPageState extends State<CurrentReliefPage> {
  Future<bool> _onWillPop() async {
    if (widget.args.point != null) {
      Navigator.of(context).pushReplacementNamed(widget.args.route,
          arguments: PointWithRoute(point: widget.args.point!.point, route: widget.args.point!.route));
    } else {
      Navigator.of(context).pushReplacementNamed(widget.args.route);
    }
    return false;
  }

  TextEditingController _controller = TextEditingController();
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
              Text("Рельеф"),
            ],
          ),
        ),
        body: RepositoryProvider(
          create: (context) => ReliefRepository(),
          child: BlocProvider<CurReliefBloc>(
            create: (context) => CurReliefBloc(RepositoryProvider.of<ReliefRepository>(context))..add(CurReliefGetEvent(widget.args.id)),
            child: BlocBuilder<CurReliefBloc, CurReliefState>(
              builder: (context, state) {
                if (state is CurReliefErrorState) {
                  return Center(
                    child: Text(state.error),
                  );
                }
                if (state is CurReliefLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is CurReliefLoadedState) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (state.isAdmin && widget.args.route == "/home/book") {
                                  await ImageRepository.uploadReliefImage(state.relief.id);
                                }
                              },
                              child: SizedBox(
                                width: double.infinity,
                                height: 250,
                                child: FutureBuilder<String>(
                                  future: ImageRepository.getFoundationImage(state.relief.id),
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
                            title: Text(state.relief.name),
                            subtitle: Text("Название"),
                          ),
                        ),
                        SizedBox(height: 10),
                        Card(
                          elevation: 1,
                          child: ListTile(
                            title: Text(state.relief.description),
                            subtitle: Text("Описание"),
                            onTap: () {
                              makeTextDialog(context, 20, state.isAdmin, state.relief.description, (value) async {
                                return ReliefRepository.updateDescription(widget.args.id, value);
                              }, () {
                                BlocProvider.of<CurFoundationBloc>(context).add(CurFoundationGetEvent(widget.args.id));
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
        ReliefRepository.deleteRelief(widget.args.id);
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
          update();
        }
      } else {
        InfoLayout.buildErrorLayout(context, "Поле не должно быть пустым");
      }
    }
  }

  Future<void> makeDialog(BuildContext context, String? currentItem, bool isAdmin, Function request, Function update) async {
    if (isAdmin && widget.args.route == "/home/book") {
      String localItem;
      currentItem == null ? localItem = 'Да' : localItem = currentItem;
      String? value = await showDialog(context: context, builder: (context) => AlertEditing.AlertEditingText(context, localItem));
      if (value != null) {
        int statusCode = request(value == "Да" ? 1 : 0);
        await Future.delayed(const Duration(seconds: 1));
        update();
      }
    }
  }
}
