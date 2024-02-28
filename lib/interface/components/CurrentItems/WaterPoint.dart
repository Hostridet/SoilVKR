import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../models/ItemWithRoute.dart';
import '../../../models/Point.dart';
import '../../../bloc/point_bloc/point_bloc.dart';
import '../../../models/PointWithRoute.dart';
import '../../../repository/PointRepository.dart';

import 'package:flutter/cupertino.dart';

class WaterItem extends StatefulWidget {
  final PointWithRoute args;
  const WaterItem({Key? key, required this.args}) : super(key: key);

  @override
  State<WaterItem> createState() => _AnimalItemState();
}

class _AnimalItemState extends State<WaterItem> {
  Future<bool> _onWillPop() async {
    Navigator.of(context).pushReplacementNamed('/home/points/one', arguments: widget.args);
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
                  Navigator.of(context).pushReplacementNamed('/home/points/one', arguments: widget.args);
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
                  Text("Воды"),
                ],
              ),
            ],
          ),
        ),
        body: RepositoryProvider(
          create: (context) => PointRepository(),
          child: BlocProvider<PointBloc>(
            create: (context) => PointBloc(RepositoryProvider.of<PointRepository>(context))..add(PointGetWaterEvent(widget.args.point.id)),
            child: BlocBuilder<PointBloc, PointState>(
              builder: (context, state) {
                if (state is PointLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is PointLoadedWaterState) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            padding: EdgeInsets.all(5),
                            itemCount: state.waterList.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                elevation: 2,
                                child: ListTile(
                                  title: Text(
                                    state.waterList[index].name,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  leading: SizedBox(
                                    width: 100,
                                    height: 200,
                                    child: DecoratedBox(
                                      decoration: const BoxDecoration(color: Colors.grey),
                                    ),
                                  ),
                                  subtitle: Text(
                                    state.waterList[index].description,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushReplacementNamed('/home/book/water',
                                        arguments:
                                            ItemWithRoute(id: state.waterList[index].id, route: '/home/points/water', point: widget.args));
                                  },
                                ),
                              );
                            }),
                      ),
                    ],
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
}
