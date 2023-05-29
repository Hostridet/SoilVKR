import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import '../../../models/Point.dart';
import '../../../bloc/point_bloc/point_bloc.dart';
import '../../../repository/PointRepository.dart';

import 'package:flutter/cupertino.dart';

class AnimalItem extends StatefulWidget {
  final Point point;
  const AnimalItem({Key? key, required this.point}) : super(key: key);

  @override
  State<AnimalItem> createState() => _AnimalItemState();
}

class _AnimalItemState extends State<AnimalItem> {
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
                Text("Животные"),
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
          )..add(PointGetAnimalEvent(widget.point.id)),
          child: BlocBuilder<PointBloc, PointState>(
            builder: (context, state) {
              if (state is PointLoadedAnimalState) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          padding: EdgeInsets.all(5),
                          itemCount: state.animalList.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              elevation: 2,
                              child: ListTile(
                                title: Text(
                                  state.animalList[index].name,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                leading: SizedBox(
                                    width: 100,
                                    height: 200,
                                    child: state.animalList[index].picture == null
                                        ? DecoratedBox(
                                      decoration: const BoxDecoration(
                                          color: Colors.grey
                                      ),
                                    )
                                        :  Image.memory(base64Decode(state.animalList[index].picture!), fit: BoxFit.fill,)
                                ),
                                subtitle: Text(
                                  state.animalList[index].description,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/home/book/animal', arguments: state.animalList[index].id);
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