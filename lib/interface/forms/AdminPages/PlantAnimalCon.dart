import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/cupertino.dart';
import 'package:soil/repository/PlantRepository.dart';
import '../../../bloc/plant_bloc/plant_bloc.dart';
import '../../../repository/ImageRepository.dart';

class PlantAnimalCon extends StatefulWidget {
  const PlantAnimalCon({Key? key}) : super(key: key);

  @override
  State<PlantAnimalCon> createState() => _PlantAnimalConState();
}

class _PlantAnimalConState extends State<PlantAnimalCon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed('/home/admin');
              },
              icon: Icon(Icons.arrow_back, size: 35,),
            ),
            Row(
              children: [
                SizedBox(width: 10,),
                Text("Растения и животные"),
              ],
            ),
          ],
        ),
        gradient: const LinearGradient(
            colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
      ),
      body: RepositoryProvider(
        create: (context) => PlantRepository(),
        child: BlocProvider<PlantBloc>(
          create: (context) => PlantBloc(
              RepositoryProvider.of<PlantRepository>(context)
          )..add(PlantGetAnimalConEvent()),
          child: BlocBuilder<PlantBloc, PlantState>(
            builder: (context, state) {
              if (state is PlantErrorState) {
                return Center(child: Text(state.error));
              }
              if (state is PlantLoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is PlantAnimalConState) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: state.plantAnimalList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Slidable(
                                endActionPane: ActionPane(
                                  motion: DrawerMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed:  (_) async {
                                        await PlantRepository.deleteConAnimal(state.plantAnimalList[index].id);
                                        BlocProvider.of<PlantBloc>(context)
                                            .add(PlantGetAnimalConEvent());
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
                                          state.plantAnimalList[index].plant.name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        leading: SizedBox(
                                          width: 100,
                                          height: 200,
                                          child: FutureBuilder<String>(
                                              future: ImageRepository.getPlantImage(state.plantAnimalList[index].plant.id),
                                              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                                if (snapshot.hasData) {
                                                  return Image.memory(base64Decode(snapshot.data!), fit: BoxFit.fill);
                                                }
                                                return Container(width: 100, height: 200, decoration: BoxDecoration(color: Color(0xffc7c7c7)));
                                              }
                                          ),
                                        ),
                                      ),
                                      Row(
                                          children: <Widget>[
                                            Expanded(
                                                child: Divider(
                                                  thickness: 1.0,
                                                )
                                            ),

                                            Icon(Icons.import_export, color: Colors.green),

                                            Expanded(
                                                child: Divider(
                                                  thickness: 1.0,
                                                )
                                            ),
                                          ]
                                      ),
                                      ListTile(
                                        title: Text(
                                          state.plantAnimalList[index].animal.name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        leading: SizedBox(
                                          width: 100,
                                          height: 200,
                                          child: FutureBuilder<String>(
                                              future: ImageRepository.getAnimalImage(state.plantAnimalList[index].animal.id),
                                              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                                if (snapshot.hasData) {
                                                  return Image.memory(base64Decode(snapshot.data!), fit: BoxFit.fill);
                                                }
                                                return Container(width: 100, height: 200, decoration: BoxDecoration(color: Color(0xffc7c7c7)));
                                              }
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              );
                            }
                        ),
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
          Navigator.of(context)
              .pushReplacementNamed('/home/admin/plantanimal/add');
        },
        child: const Icon(Icons.add, color: Colors.white, size: 35),
      ),
    );
  }
}
