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

class ReliefItem extends StatefulWidget {
  final PointWithRoute args;
  const ReliefItem({Key? key, required this.args}) : super(key: key);

  @override
  State<ReliefItem> createState() => _AnimalItemState();
}

class _AnimalItemState extends State<ReliefItem> {
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
                  Text("Рельеф"),
                ],
              ),
            ],
          ),
        ),
        body: RepositoryProvider(
          create: (context) => PointRepository(),
          child: BlocProvider<PointBloc>(
            create: (context) => PointBloc(RepositoryProvider.of<PointRepository>(context))..add(PointGetReliefEvent(widget.args.point.id)),
            child: BlocBuilder<PointBloc, PointState>(
              builder: (context, state) {
                if (state is PointLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is PointLoadedReliefState) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            padding: EdgeInsets.all(5),
                            itemCount: state.reliefList.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                elevation: 2,
                                child: ListTile(
                                  title: Text(
                                    state.reliefList[index].name,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  leading: SizedBox(
                                      width: 100,
                                      height: 200,
                                      child: state.reliefList[index].image == null
                                          ? DecoratedBox(
                                              decoration: const BoxDecoration(color: Colors.grey),
                                            )
                                          : Image.memory(
                                              base64Decode(state.reliefList[index].image!),
                                              fit: BoxFit.fill,
                                            )),
                                  subtitle: Text(
                                    state.reliefList[index].description,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushReplacementNamed('/home/book/relief',
                                        arguments: ItemWithRoute(
                                            id: state.reliefList[index].id, route: '/home/points/relief', point: widget.args));
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
