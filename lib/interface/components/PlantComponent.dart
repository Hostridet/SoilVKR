import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/plant_bloc/plant_bloc.dart';
import '../../models/ItemWithRoute.dart';
import '../../repository/ImageRepository.dart';
import '../../repository/PlantRepository.dart';

class PlantComponent extends StatefulWidget {
  const PlantComponent({Key? key}) : super(key: key);

  @override
  State<PlantComponent> createState() => _PlantComponentState();
}

class _PlantComponentState extends State<PlantComponent> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late FocusNode nameFocus;
  late FocusNode descriptionFocus;
  late bool checkValue;

  @override
  void initState() {
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    nameFocus = FocusNode();
    descriptionFocus = FocusNode();
    checkValue = false;
    super.initState();
  }
  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    nameFocus.dispose();
    descriptionFocus.dispose();
    super.dispose();
  }

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
            if (state is PlantViewUpdateState) {
              return Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(nameFocus);
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color:  Colors.green),
                              borderRadius: BorderRadius.circular(5.5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color:  Colors.green),
                              borderRadius: BorderRadius.circular(5.5)),
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: "Название растения",),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        maxLines: 6,
                        controller: descriptionController,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(descriptionFocus);
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color:  Colors.green),
                              borderRadius: BorderRadius.circular(5.5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color:  Colors.green),
                              borderRadius: BorderRadius.circular(5.5)),
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: "Описание растения",),
                      ),
                      SizedBox(height: 10,),
                      CheckboxListTile(
                          title: Text("Кормовое растение"),
                          value: checkValue,
                          onChanged: (bool? newValue) {
                            setState(() {
                              checkValue = newValue!;
                            });
                          }
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 50,
                            child: OutlinedButton(
                              child: Text("Отмена"),
                              style: OutlinedButton.styleFrom(
                                primary: Colors.red,
                                side: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              onPressed: () {
                                BlocProvider.of<PlantBloc>(context)
                                    .add(PlantGetEvent());
                                nameController.clear();
                                descriptionController.clear();
                              },
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            height: 50,
                            child: ElevatedButton(
                              child: Text("Добавить"),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                elevation: 0,
                              ),
                              onPressed: () {
                                BlocProvider.of<PlantBloc>(context)
                                    .add(PlantUpdateEvent(nameController.text, descriptionController.text, checkValue));
                                nameController.clear();
                                descriptionController.clear();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              );
            }
            if (state is PlantLoadedState) {
              return Column(
                children: [
                  state.isAdmin
                  ? Visibility(
                    child: Padding(
                        padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                        child: Card(
                          elevation: 2,
                          child: ListTile(
                            title: Text("Добавить"),
                            subtitle: Text("Добавить новое растение"),
                            leading: Icon(Icons.add, size: 35,),
                            onTap: () {
                              BlocProvider.of<PlantBloc>(context)
                                  .add(PlantViewUpdateEvent());
                            },
                          ),
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
                                child: FutureBuilder<String>(
                                    future: ImageRepository.getPlantImage(state.plantList[index].id),
                                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                      if (snapshot.hasData) {
                                        return Image.memory(base64Decode(snapshot.data!), fit: BoxFit.fill);
                                      }
                                      return Container(width: 100, height: 200, decoration: BoxDecoration(color: Color(0xffc7c7c7)));
                                    }
                                ),
                                ),
                              subtitle: Text(
                                  state.plantList[index].description,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/home/book/plant', arguments: ItemWithRoute(id: state.plantList[index].id, route: '/home/book'));
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
