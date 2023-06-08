import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import '../../../models/ItemWithRoute.dart';
import '../../../models/Point.dart';
import '../../../bloc/point_bloc/point_bloc.dart';
import '../../../models/PointWithRoute.dart';
import '../../../repository/PointRepository.dart';

class SoilItem extends StatefulWidget {
  final PointWithRoute args;
  const SoilItem({Key? key, required this.args}) : super(key: key);

  @override
  State<SoilItem> createState() => _SoilItemState();
}

class _SoilItemState extends State<SoilItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed('/home/points/one', arguments: widget.args);
              },
              icon: Icon(Icons.arrow_back, size: 35,),
            ),
            Row(
              children: [
                SizedBox(width: 10,),
                Text("Почвы"),
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
          )..add(PointGetSoilEvent(widget.args.point.id)),
          child: BlocBuilder<PointBloc, PointState>(
            builder: (context, state) {
              if (state is PointLoadedSoilState) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.soilList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              elevation: 2,
                              child: ListTile(
                                title: Text(
                                  state.soilList[index].name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                leading: SizedBox(
                                    width: 100,
                                    height: 200,
                                    child: state.soilList[index].image == null
                                        ? DecoratedBox(
                                      decoration: const BoxDecoration(
                                          color: Colors.grey
                                      ),
                                    )
                                        :  Image.memory(base64Decode(state.soilList[index].image!), fit: BoxFit.fill,)
                                ),
                                subtitle: Text(
                                  state.soilList[index].name,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/home/book/soil', arguments: ItemWithRoute(id: state.soilList[index].id, route: '/home/points/soil', point: widget.args));
                                },

                              ),
                            );
                          }
                      ),
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
