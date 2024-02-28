import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../bloc/soil_bloc/soil_bloc.dart';
import '../../../repository/ImageRepository.dart';
import '../../../repository/SoilRepository.dart';

class LocationWaterCon extends StatefulWidget {
  const LocationWaterCon({Key? key}) : super(key: key);

  @override
  State<LocationWaterCon> createState() => _LocationSoilConState();
}

class _LocationSoilConState extends State<LocationWaterCon> {
  Future<bool> _onWillPop() async {
    Navigator.of(context).pushReplacementNamed('/home/admin');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/home/admin');
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 35,
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text("Территория и воды"),
                ],
              ),
            ],
          ),
        ),
        body: RepositoryProvider(
          create: (context) => SoilRepository(),
          child: BlocProvider<SoilBloc>(
            create: (context) => SoilBloc(RepositoryProvider.of<SoilRepository>(context))..add(WaterGetPointConEvent()),
            child: BlocBuilder<SoilBloc, SoilState>(
              builder: (context, state) {
                if (state is SoilErrorState) {
                  return Center(child: Text(state.error));
                }
                if (state is SoilLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is WaterPointConState) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: state.waterPointList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Slidable(
                                  endActionPane: ActionPane(
                                    motion: DrawerMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (_) async {
                                          await SoilRepository.deleteConPoint(state.waterPointList[index].id);
                                          BlocProvider.of<SoilBloc>(context).add(SoilGetPointConEvent());
                                        },
                                        backgroundColor: Color(0xFFFE4A49),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Удалить',
                                      ),
                                    ],
                                  ),
                                  child: Card(
                                    elevation: 2,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 10),
                                        ListTile(
                                          title: Text(
                                            state.waterPointList[index].water.name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          leading: SizedBox(
                                            width: 100,
                                            height: 200,
                                            child: Container(width: 100, height: 200, decoration: BoxDecoration(color: Color(0xffc7c7c7))),
                                          ),
                                        ),
                                        Row(children: <Widget>[
                                          Expanded(
                                              child: Divider(
                                            thickness: 1.0,
                                          )),
                                          Icon(Icons.import_export, color: Colors.green),
                                          Expanded(
                                              child: Divider(
                                            thickness: 1.0,
                                          )),
                                        ]),
                                        ListTile(
                                          title: Text(
                                            "${state.waterPointList[index].point.x} ${state.waterPointList[index].point.y}",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          leading: Container(
                                            width: 100,
                                            height: 200,
                                            child: Icon(Icons.location_on, size: 50, color: Colors.red),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/home/admin/locationwater/add');
          },
          child: const Icon(Icons.add, color: Colors.white, size: 35),
        ),
      ),
    );
  }
}
