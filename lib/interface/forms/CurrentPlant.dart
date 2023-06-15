import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cur_plant_bloc/cur_plant_bloc.dart';
import '../../models/ItemWithRoute.dart';
import '../../models/PointWithRoute.dart';
import '../../repository/ImageRepository.dart';
import '../../repository/PlantRepository.dart';
import '../AlertEditingTextWidget.dart';

class CurrentPlantPage extends StatefulWidget {
  final ItemWithRoute args;
  CurrentPlantPage({Key? key, required this.args}) : super(key: key);

  @override
  State<CurrentPlantPage> createState() => _CurrentPlantPageState();
}

class _CurrentPlantPageState extends State<CurrentPlantPage> {
  TextEditingController _controller = TextEditingController();
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
            Text("Растение"),
          ],
        ),
        gradient: const LinearGradient(colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
      ),
      body: RepositoryProvider(
        create: (context) => PlantRepository(),
        child: BlocProvider<CurPlantBloc>(
          create: (context) => CurPlantBloc(
              RepositoryProvider.of<PlantRepository>(context)
          )..add(CurPlantGetEvent(widget.args.id)),
          child: BlocBuilder<CurPlantBloc, CurPlantState>(
            builder: (context, state) {
              if (state is CurPlantLoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is CurPlantErrorState) {
                return Center(
                  child: Text(state.error),
                );
              }
              if (state is CurPlantLoadedState) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 250,
                            child: FutureBuilder<String>(
                              future: ImageRepository.getPlantImage(state.plant.id),
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  padding: EdgeInsets.only(top: 210, left: 10),
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    state.plant.name,
                                    style: TextStyle(color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.0),
                                  )),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(state.plant.description),
                          subtitle: Text("Описание"),
                          onTap: ()  async {
                            // _controller.text = state.plant.description;
                            // String? value = await showDialog(
                            //     context: context,
                            //     builder: (context) => AlertEditingTextWidget.AlertEditingText(context, 20, _controller),
                            // );
                            // print(value);
                            // _controller.clear();
                            makeTextDialog(context, 20, state.plant.description, (value) {print(value);},
                                    () { BlocProvider.of<CurPlantBloc>(context).add(CurPlantGetEvent(widget.args.id));});
                          },
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.isFodder != null
                                  ? state.plant.isFodder == 0 ? "Нет" : "Да"
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Является кормовым"),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.isExacting != null
                                  ? state.plant.isExacting == 0 ? "Нет" : "Да"
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Необходим солнечный свет"),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.isOneYears != null
                                  ? state.plant.isOneYears == 0 ? "Нет" : "Да"
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Однолетнее"),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.isTwoYears != null
                                  ? state.plant.isTwoYears == 0 ? "Нет" : "Да"
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Двухлетнее"),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.isManyYears != null
                                  ? state.plant.isManyYears == 0 ? "Нет" : "Да"
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Многолетнее"),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.climat != null
                                  ? state.plant.climat!
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Климат"),
                          onTap: () async {
                            makeTextDialog(context, 1, state.plant.climat!, (value) {print(value);},
                                    () { BlocProvider.of<CurPlantBloc>(context).add(CurPlantGetEvent(widget.args.id));});
                          },
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.minTemp != null
                                  ? "${state.plant.minTemp} °C"
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Минимальная температура"),
                          onTap: () async {
                            makeTextDialog(context, 1, state.plant.minTemp!.toString(), (value) {print(value);},
                                    () { BlocProvider.of<CurPlantBloc>(context).add(CurPlantGetEvent(widget.args.id));});
                          },
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.maxTemp != null
                                  ? "${state.plant.maxTemp} °C"
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Максимальная температура"),
                          onTap: () async {
                            makeTextDialog(context, 1, state.plant.maxTemp!.toString(), (value) {print(value);},
                                    () { BlocProvider.of<CurPlantBloc>(context).add(CurPlantGetEvent(widget.args.id));});
                          },
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.kingdom != null
                                  ? state.plant.kingdom!
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Царство"),
                          onTap: () async {
                            makeTextDialog(context, 1, state.plant.kingdom!.toString(), (value) {print(value);},
                                    () { BlocProvider.of<CurPlantBloc>(context).add(CurPlantGetEvent(widget.args.id));});
                          },
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.philum != null
                                  ? state.plant.philum!
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Тип"),
                          onTap: () async {
                            makeTextDialog(context, 1, state.plant.philum!.toString(), (value) {print(value);},
                                    () { BlocProvider.of<CurPlantBloc>(context).add(CurPlantGetEvent(widget.args.id));});
                          },
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.classes != null
                                  ? state.plant.classes!
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Класс"),
                          onTap: () async {
                            makeTextDialog(context, 1, state.plant.classes!, (value) {print(value);},
                                    () { BlocProvider.of<CurPlantBloc>(context).add(CurPlantGetEvent(widget.args.id));});
                          },
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.order != null
                                  ? state.plant.order!
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Отряд"),
                          onTap: () async {
                            makeTextDialog(context, 1, state.plant.order!, (value) {print(value);},
                                    () { BlocProvider.of<CurPlantBloc>(context).add(CurPlantGetEvent(widget.args.id));});
                          },
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.family != null
                                  ? state.plant.family!
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Семейство"),
                          onTap: () async {
                            makeTextDialog(context, 1, state.plant.family!, (value) {print(value);},
                                    () { BlocProvider.of<CurPlantBloc>(context).add(CurPlantGetEvent(widget.args.id));});
                          },
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.genus != null
                                  ? state.plant.genus!
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Род"),
                          onTap: () async {
                            makeTextDialog(context, 1, state.plant.genus!, (value) {print(value);},
                                    () { BlocProvider.of<CurPlantBloc>(context).add(CurPlantGetEvent(widget.args.id));});
                          },
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.species != null
                                  ? state.plant.species!
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Вид"),
                          onTap: () async {
                            makeTextDialog(context, 2, state.plant.species!, (value) {print(value);},
                                    () { BlocProvider.of<CurPlantBloc>(context).add(CurPlantGetEvent(widget.args.id));});
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
        PlantRepository.deletePlant(widget.args.id);
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
  Future<void> makeTextDialog(BuildContext context, int maxLine, String text, Function request, Function update) async {
    _controller.text = text;
    String? value = await showDialog(
      context: context,
      builder: (context) => AlertEditingTextWidget.AlertEditingText(context, maxLine, _controller),
    );
    request(value);
    update();
  }
}
