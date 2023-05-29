import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/plant_bloc/plant_bloc.dart';
import '../../repository/PlantRepository.dart';

class PlantComponent extends StatefulWidget {
  const PlantComponent({Key? key}) : super(key: key);

  @override
  State<PlantComponent> createState() => _PlantComponentState();
}

class _PlantComponentState extends State<PlantComponent> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PlantRepository(),
      child: BlocProvider<PlantBloc>(
        create: (context) => PlantBloc(
            RepositoryProvider.of<PlantRepository>(context)
        )..add(PlantGetEvent()),
        child: BlocBuilder<PlantBloc, PlantState>(
          builder: (context, state) {
            if (state is PlantErrorState) {
              return Center(
                child: Text(state.error),
              );
            }
            if (state is PlantLoadedState) {
              return Column(
                children: [
                  state.isAdmin == true
                  ? Padding(
                      padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                      child: Card(
                        elevation: 2,
                        child: ListTile(
                          title: Text("Добавить"),
                          subtitle: Text("Добавить новое растение"),
                          leading: Icon(Icons.add, size: 35,),
                          onTap: () {

                          },
                        ),
                      ),
                  )
                  : Container(),
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
          }
        ),
      ),
    );
  }
}
