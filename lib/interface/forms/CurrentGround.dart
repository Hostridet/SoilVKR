

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cur_ground_bloc/cur_ground_bloc.dart';
import '../../repository/GroundRepository.dart';
import '../../repository/ImageRepository.dart';

class CurrentGroundPage extends StatefulWidget {
  final int id;
  CurrentGroundPage({Key? key, required this.id}) : super(key: key);

  @override
  State<CurrentGroundPage> createState() => _CurrentGroundPageState();
}

class _CurrentGroundPageState extends State<CurrentGroundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title:  Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed('/home/book');
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
          )..add(CurGroundGetEvent(widget.id)),
          child: BlocBuilder<CurGroundBloc, CurGroundState>(
            builder: (context, state) {
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
                          SizedBox(
                            width: double.infinity,
                            height: 250,
                            child: FutureBuilder<String>(
                              future: ImageRepository.getGroundImage(state.ground.id),
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
                          title: Text(state.ground.name),
                          subtitle: Text("Название"),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(state.ground.description),
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
                              state.ground.density != null
                                  ? state.ground.density!.toString()
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Плотность"),
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
                          subtitle: Text("Полезные ископаемые"),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.ground.moos != null
                                  ? state.ground.moos!
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
}
