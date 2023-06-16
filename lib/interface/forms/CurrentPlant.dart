import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soil/interface/components/AlertEditingWidget.dart';
import 'package:soil/interface/components/InfoLayout.dart';

import '../../bloc/cur_plant_bloc/cur_plant_bloc.dart';
import '../../models/ItemWithRoute.dart';
import '../../models/PointWithRoute.dart';
import '../../repository/ImageRepository.dart';
import '../../repository/PlantRepository.dart';
import '../components/AlertEditingTextWidget.dart';

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
                          GestureDetector(
                            onTap: () async {
                              if (state.isAdmin && widget.args.route == "/home/book") {
                                await ImageRepository.uploadPlantImage(state.plant.id);
                              }
                            },
                            child: SizedBox(
                              width: double.infinity,
                              height: 250,
                              child: FutureBuilder<String>(
                                future: ImageRepository.getPlantImage(state.plant.id),
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
                            makeTextDialog(context, 20, state.isAdmin, state.plant.description, (value) async {return PlantRepository.updateDescription(widget.args.id, value);},
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
                          onTap: () async{
                            makeDialog(context, state.plant.isFodder == 0 ? "Нет" : "Да", state.isAdmin, (value) async {return PlantRepository.updateIsFodder(widget.args.id, value);},
                                    () { BlocProvider.of<CurPlantBloc>(context).add(CurPlantGetEvent(widget.args.id));});
                          },
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
                          onTap: () {
                            makeDialog(context, state.plant.isExacting == 0 ? "Нет" : "Да", state.isAdmin, (value) async {return PlantRepository.updateIsExacting(widget.args.id, value);},
                                    () { BlocProvider.of<CurPlantBloc>(context).add(CurPlantGetEvent(widget.args.id));});
                          },
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
                          onTap: () {
                            makeDialog(context, state.plant.isOneYears == 0 ? "Нет" : "Да", state.isAdmin, (value) async {return PlantRepository.updateIsOneYear(widget.args.id, value);},
                                    () { BlocProvider.of<CurPlantBloc>(context).add(CurPlantGetEvent(widget.args.id));});
                          },
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
                          onTap: () {
                            makeDialog(context, state.plant.isTwoYears == 0 ? "Нет" : "Да", state.isAdmin, (value) async {return PlantRepository.updateIsTwoYear(widget.args.id, value);},
                                    () { BlocProvider.of<CurPlantBloc>(context).add(CurPlantGetEvent(widget.args.id));});
                          },
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
                          onTap: () {
                            makeDialog(context, state.plant.isManyYears == 0 ? "Нет" : "Да", state.isAdmin, (value) async {return PlantRepository.updateIsManyYear(widget.args.id, value);},
                                    () { BlocProvider.of<CurPlantBloc>(context).add(CurPlantGetEvent(widget.args.id));});
                          },
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
                            makeTextDialog(context, 1, state.isAdmin, state.plant.climat == null ? "" : state.plant.climat!, (value) async {return PlantRepository.updateClimat(widget.args.id, value);},
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
                            makeTextDialog(context, 1, state.isAdmin, state.plant.minTemp == null ? "0" : state.plant.minTemp.toString(), (value) async {return PlantRepository.updateTempMin(widget.args.id, value);},
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
                            makeTextDialog(context, 1, state.isAdmin, state.plant.maxTemp == null ? "0" : state.plant.maxTemp.toString(), (value) async {return PlantRepository.updateTempMax(widget.args.id, value);},
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
                            makeTextDialog(context, 1, state.isAdmin, state.plant.kingdom == null ? "" : state.plant.kingdom!, (value) async {return PlantRepository.updateKingdom(widget.args.id, value);},
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
                            makeTextDialog(context, 1, state.isAdmin, state.plant.philum == null ? "" : state.plant.philum!, (value) async {return PlantRepository.updatePhilum(widget.args.id, value);},
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
                            makeTextDialog(context, 1, state.isAdmin, state.plant.classes == null ? "" : state.plant.classes!, (value) async {return PlantRepository.updateClass(widget.args.id, value);},
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
                            makeTextDialog(context, 1, state.isAdmin, state.plant.order == null ? "" : state.plant.order!, (value) async {return PlantRepository.updateOrder(widget.args.id, value);},
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
                            makeTextDialog(context, 1, state.isAdmin, state.plant.family == null ? "" : state.plant.family!, (value) async {return PlantRepository.updateFamily(widget.args.id, value);},
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
                            makeTextDialog(context, 1, state.isAdmin, state.plant.genus == null ? "" : state.plant.genus!, (value) async {return PlantRepository.updateGenus(widget.args.id, value);},
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
                            makeTextDialog(context, 2, state.isAdmin, state.plant.species == null ? "" : state.plant.species!, (value) async {return PlantRepository.updateSpecies(widget.args.id, value);},
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
          update();
        }
      }
    }
  }
  Future<void> makeDialog(BuildContext context, String? currentItem, bool isAdmin, Function request, Function update) async {
    if (isAdmin && widget.args.route == "/home/book") {
      String localItem;
      currentItem == null ? localItem = 'Да': localItem = currentItem;
      String? value = await showDialog(
          context: context,
          builder: (context) => AlertEditing.AlertEditingText(context, localItem)
      );
      request(value == "Да" ? 1 : 0);
      update();
    }
  }
}
