import 'package:flutter/cupertino.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

import '../../bloc/cur_soil_bloc/cur_soil_bloc.dart';
import '../../models/ItemWithRoute.dart';
import '../../models/PointWithRoute.dart';
import '../../repository/ImageRepository.dart';
import '../../repository/SoilRepository.dart';

class CurrentSoilPage extends StatefulWidget {
  final ItemWithRoute args;
  const CurrentSoilPage({Key? key, required this.args}) : super(key: key);

  @override
  State<CurrentSoilPage> createState() => _CurrentSoilPageState();
}

class _CurrentSoilPageState extends State<CurrentSoilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        create: (context) => SoilRepository(),
        child: BlocProvider<CurSoilBloc>(
          create: (context) => CurSoilBloc(
              RepositoryProvider.of<SoilRepository>(context)
          )..add(CurSoilGetEvent(widget.args.id)),
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
                          SizedBox(
                            width: double.infinity,
                            height: 250,
                            child: FutureBuilder<String>(
                              future: ImageRepository.getSoilImage(state.soil.id),
                              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                if (snapshot.hasData) {
                                  return FittedBox(child: Image.memory(base64Decode(snapshot.data!)), fit: BoxFit.fill);
                                }
                                else {
                                  return Container();

                                }
                              },
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
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(state.soil.description),
                          subtitle: Text("Описание"),
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
                              state.soil.acidity != null
                                  ? state.soil.acidity!
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Кислотность"),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.soil.minerals != null
                                  ? state.soil.minerals!
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Полезные ископаемые"),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.soil.profile != null
                                  ? state.soil.profile!
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Очертание"),
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
        SoilRepository.deleteSoil(widget.args.id);
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
}
