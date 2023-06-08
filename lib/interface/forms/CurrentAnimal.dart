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

class CurrentAnimalPage extends StatefulWidget {
  final ItemWithRoute args;
  const CurrentAnimalPage({Key? key, required this.args}) : super(key: key);

  @override
  State<CurrentAnimalPage> createState() => _CurrentAnimalPageState();
}

class _CurrentAnimalPageState extends State<CurrentAnimalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
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
              if (state is CurAnimalLoadedState) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 250,
                            child: FutureBuilder<String>(
                              future: ImageRepository.getAnimalImage(state.animal.id),
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
}
