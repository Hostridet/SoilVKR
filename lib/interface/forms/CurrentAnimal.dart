import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';

import '../../bloc/cur_animal_bloc/cur_animal_bloc.dart';
import '../../models/ItemWithRoute.dart';
import '../../models/PointWithRoute.dart';
import '../../repository/AnimalRepository.dart';
import '../../repository/ImageRepository.dart';
import '../components/AlertEditingTextWidget.dart';
import '../components/AlertEditingWidget.dart';
import '../components/InfoLayout.dart';

class CurrentAnimalPage extends StatefulWidget {
  final ItemWithRoute args;
  const CurrentAnimalPage({Key? key, required this.args}) : super(key: key);

  @override
  State<CurrentAnimalPage> createState() => _CurrentAnimalPageState();
}

class _CurrentAnimalPageState extends State<CurrentAnimalPage> {
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
  TextEditingController _controller = TextEditingController();
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
              Text("Животные"),
            ],
          ),
          gradient: const LinearGradient(colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
        ),
        body: RepositoryProvider(
          create: (context) => AnimalRepository(),
          child: BlocProvider<CurAnimalBloc>(
            create: (context) => CurAnimalBloc(
                RepositoryProvider.of<AnimalRepository>(context)
            )..add(CurAnimalGetEvent(widget.args.id)),
            child: BlocBuilder<CurAnimalBloc, CurAnimalState>(
              builder: (context, state) {
                if (state is CurAnimalErrorState) {
                  return Center(
                    child: Text(state.error),
                  );
                }
                if (state is CurAnimalLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is CurAnimalLoadedState) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (state.isAdmin && widget.args.route == "/home/book") {
                                  await ImageRepository.uploadAnimalImage(state.animal.id);
                                }
                              },
                              child: SizedBox(
                                width: double.infinity,
                                height: 250,
                                child: FutureBuilder<String>(
                                  future: ImageRepository.getAnimalImage(state.animal.id),
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
                                      state.animal.name,
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
                            title: Text(state.animal.description),
                            subtitle: Text("Описание"),
                            onTap: () {
                              makeTextDialog(context, 20, state.isAdmin, state.animal.description, (value) async {return AnimalRepository.updateDescription(widget.args.id, value);},
                                      () { BlocProvider.of<CurAnimalBloc>(context).add(CurAnimalGetEvent(widget.args.id));});
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
                                state.animal.kingdom != null
                                    ? state.animal.kingdom!
                                    : "Отсутствует"
                            ),
                            subtitle: Text("Царство"),
                            onTap: () {
                              makeTextDialog(context, 1, state.isAdmin, state.animal.kingdom == null ? "" : state.animal.kingdom!, (value) async {return AnimalRepository.updateKingdom(widget.args.id, value);},
                                      () { BlocProvider.of<CurAnimalBloc>(context).add(CurAnimalGetEvent(widget.args.id));});
                            },
                          ),
                        ),
                        Card(
                          elevation: 1,
                          child: ListTile(
                            title: Text(
                                state.animal.philum != null
                                    ? state.animal.philum!
                                    : "Отсутствует"
                            ),
                            subtitle: Text("Тип"),
                            onTap: () {
                              makeTextDialog(context, 1, state.isAdmin, state.animal.philum == null ? "" : state.animal.philum!, (value) async {return AnimalRepository.updatePhilum(widget.args.id, value);},
                                      () { BlocProvider.of<CurAnimalBloc>(context).add(CurAnimalGetEvent(widget.args.id));});
                            },
                          ),
                        ),
                        Card(
                          elevation: 1,
                          child: ListTile(
                            title: Text(
                                state.animal.classes != null
                                    ? state.animal.classes!
                                    : "Отсутствует"
                            ),
                            subtitle: Text("Класс"),
                            onTap: () {
                              makeTextDialog(context, 1, state.isAdmin, state.animal.classes == null ? "" : state.animal.classes!, (value) async {return AnimalRepository.updateClass(widget.args.id, value);},
                                      () { BlocProvider.of<CurAnimalBloc>(context).add(CurAnimalGetEvent(widget.args.id));});
                            },
                          ),
                        ),
                        Card(
                          elevation: 1,
                          child: ListTile(
                            title: Text(
                                state.animal.order != null
                                    ? state.animal.order!
                                    : "Отсутствует"
                            ),
                            subtitle: Text("Отряд"),
                            onTap: () {
                              makeTextDialog(context, 1, state.isAdmin, state.animal.order == null ? "" : state.animal.order!, (value) async {return AnimalRepository.updateOrder(widget.args.id, value);},
                                      () { BlocProvider.of<CurAnimalBloc>(context).add(CurAnimalGetEvent(widget.args.id));});
                            },
                          ),
                        ),
                        Card(
                          elevation: 1,
                          child: ListTile(
                            title: Text(
                                state.animal.family != null
                                    ? state.animal.family!
                                    : "Отсутствует"
                            ),
                            subtitle: Text("Семейство"),
                            onTap: () {
                              makeTextDialog(context, 1, state.isAdmin, state.animal.family == null ? "" : state.animal.family!, (value) async {return AnimalRepository.updateFamily(widget.args.id, value);},
                                      () { BlocProvider.of<CurAnimalBloc>(context).add(CurAnimalGetEvent(widget.args.id));});
                            },
                          ),
                        ),
                        Card(
                          elevation: 1,
                          child: ListTile(
                            title: Text(
                                state.animal.genus != null
                                    ? state.animal.genus!
                                    : "Отсутствует"
                            ),
                            subtitle: Text("Род"),
                            onTap: () {
                              makeTextDialog(context, 1, state.isAdmin, state.animal.genus == null ? "" : state.animal.genus!, (value) async {return AnimalRepository.updateGenus(widget.args.id, value);},
                                      () { BlocProvider.of<CurAnimalBloc>(context).add(CurAnimalGetEvent(widget.args.id));});
                            },
                          ),
                        ),
                        Card(
                          elevation: 1,
                          child: ListTile(
                            title: Text(
                                state.animal.species != null
                                    ? state.animal.species!
                                    : "Отсутствует"
                            ),
                            subtitle: Text("Вид"),
                            onTap: () {
                              makeTextDialog(context, 1, state.isAdmin, state.animal.species == null ? "" : state.animal.species!, (value) async {return AnimalRepository.updateSpecies(widget.args.id, value);},
                                      () { BlocProvider.of<CurAnimalBloc>(context).add(CurAnimalGetEvent(widget.args.id));});
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
        AnimalRepository.deleteAnimal(widget.args.id);
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
      else {
        InfoLayout.buildErrorLayout(context, "Поле не должно быть пустым");
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
      if (value != null) {
        int statusCode = request(value == "Да" ? 1 : 0);
        await Future.delayed(const Duration(seconds: 1));
        update();
      }
    }
  }
}
