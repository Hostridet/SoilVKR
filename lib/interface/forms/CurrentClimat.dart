import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:soil/bloc/cur_climat_bloc/cur_climat_bloc.dart';
import 'package:soil/interface/components/AlertEditingTextWidget.dart';
import 'package:soil/interface/components/InfoLayout.dart';
import 'package:soil/models/ItemWithRoute.dart';
import 'package:soil/models/PointWithRoute.dart';
import 'package:soil/repository/ClimatRepository.dart';

class CurrentClimatPage extends StatefulWidget {
  final ItemWithRoute args;
  const CurrentClimatPage({Key? key, required this.args}) : super(key: key);

  @override
  State<CurrentClimatPage> createState() => _CurrentSoilPageState();
}

class _CurrentSoilPageState extends State<CurrentClimatPage> {
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
              Text("Климат"),
            ],
          ),
        ),
        body: RepositoryProvider(
          create: (context) => ClimatRepository(),
          child: BlocProvider<CurClimatBloc>(
            create: (context) => CurClimatBloc(RepositoryProvider.of<ClimatRepository>(context))..add(CurClimatGetEvent(widget.args.id)),
            child: BlocBuilder<CurClimatBloc, CurClimatState>(
              builder: (context, state) {
                if (state is CurClimatErrorState) {
                  return Center(
                    child: Text(state.error),
                  );
                }
                if (state is CurClimatLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is CurClimatLoadedState) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        FittedBox(child: Image.asset("assets/no-image.jpg")),
                        SizedBox(height: 10),
                        Card(
                          elevation: 1,
                          child: ListTile(
                            title: Text(state.climat.name),
                            subtitle: Text("Название"),
                          ),
                        ),
                        Card(
                          elevation: 1,
                          child: ListTile(
                            title: Text(state.climat.description),
                            subtitle: Text("Описание"),
                            onTap: () {
                              makeTextDialog(context, 15, state.isAdmin, state.climat.description, (value) async {
                                return ClimatRepository.updateDescription(widget.args.id, value);
                              }, () {
                                BlocProvider.of<CurClimatBloc>(context).add(CurClimatGetEvent(widget.args.id));
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
        ClimatRepository.deleteClimat(widget.args.id);
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
