import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import '../../../models/Point.dart';
import '../../../bloc/point_bloc/point_bloc.dart';
import '../../../repository/PointRepository.dart';

class PlantItem extends StatefulWidget {
  final Point point;
  const PlantItem({Key? key, required this.point}) : super(key: key);

  @override
  State<PlantItem> createState() => _PlantItemState();
}

class _PlantItemState extends State<PlantItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed('/home/points/one', arguments: widget.point);
              },
              icon: Icon(Icons.arrow_back, size: 35,),
            ),
            Row(
              children: [
                SizedBox(width: 10,),
                Text("Растения"),
              ],
            ),
          ],
        ),
        gradient: const LinearGradient(
            colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
      ),
      body: RepositoryProvider(
        create: (context) => PointRepository(),
        child: BlocProvider<PointBloc>(
          create: (context) => PointBloc(
              RepositoryProvider.of<PointRepository>(context)
          )..add(PointGetPlantEvent(widget.point.id)),
          child: BlocBuilder<PointBloc, PointState>(
            builder: (context, state) {
              if (state is PointLoadedPlantState) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.plantList.length,
                          padding: EdgeInsets.all(5),
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              elevation: 2,
                              child: ListTile(
                                title: Text(
                                  state.plantList[index].name,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                leading: SizedBox(
                                    width: 100,
                                    height: 200,
                                    child: state.plantList[index].image == null
                                        ? DecoratedBox(
                                      decoration: const BoxDecoration(
                                          color: Colors.grey
                                      ),
                                    )
                                        :  Image.memory(base64Decode(state.plantList[index].image!), fit: BoxFit.fill,)
                                ),
                                subtitle: Text(
                                  state.plantList[index].description,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/home/book/plant', arguments: state.plantList[index].id);
                                },

                              ),
                            );
                          }
                      )
                    ),
                  ],
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