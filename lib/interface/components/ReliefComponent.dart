import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soil/bloc/relief_bloc/relief_bloc.dart';
import 'package:soil/interface/components/InfoLayout.dart';
import 'package:soil/models/ItemWithRoute.dart';
import 'package:soil/repository/ImageRepository.dart';
import 'package:soil/repository/ReliefRepository.dart';

class ReliefComponent extends StatefulWidget {
  const ReliefComponent({Key? key}) : super(key: key);

  @override
  State<ReliefComponent> createState() => _AnimalComponentState();
}

class _AnimalComponentState extends State<ReliefComponent> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late FocusNode nameFocus;
  late FocusNode descriptionFocus;

  @override
  void initState() {
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    nameFocus = FocusNode();
    descriptionFocus = FocusNode();
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
      create: (context) => ReliefRepository(),
      child: BlocProvider<ReliefBloc>(
        create: (context) => ReliefBloc(RepositoryProvider.of<ReliefRepository>(context))..add(ReliefGetEvent()),
        child: BlocBuilder<ReliefBloc, ReliefState>(builder: (context, state) {
          if (state is ReliefErrorState) {
            return Center(
              child: Text(state.error),
            );
          }
          if (state is ReliefLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ReliefViewUpdateState) {
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
                      enabledBorder:
                          OutlineInputBorder(borderSide: const BorderSide(color: Colors.green), borderRadius: BorderRadius.circular(5.5)),
                      focusedBorder:
                          OutlineInputBorder(borderSide: const BorderSide(color: Colors.green), borderRadius: BorderRadius.circular(5.5)),
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.transparent,
                      hintText: "Название рельефа",
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 6,
                    controller: descriptionController,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(descriptionFocus);
                    },
                    decoration: InputDecoration(
                      enabledBorder:
                          OutlineInputBorder(borderSide: const BorderSide(color: Colors.green), borderRadius: BorderRadius.circular(5.5)),
                      focusedBorder:
                          OutlineInputBorder(borderSide: const BorderSide(color: Colors.green), borderRadius: BorderRadius.circular(5.5)),
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.transparent,
                      hintText: "Описание рельефа",
                    ),
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
                            BlocProvider.of<ReliefBloc>(context).add(ReliefGetEvent());
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
                            if (nameController.text == "" || descriptionController.text == "") {
                              InfoLayout.buildErrorLayout(context, "Все поля должны быть заполнены");
                              return;
                            }
                            if (nameController.text.length < 3 || descriptionController.text.length < 3) {
                              InfoLayout.buildErrorLayout(context, "Длина заполненных полей должна быть больше 2");
                              return;
                            }
                            BlocProvider.of<ReliefBloc>(context).add(ReliefUpdateEvent(nameController.text, descriptionController.text));
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
          if (state is ReliefLoadedState) {
            return Column(
              children: [
                state.isAdmin == true
                    ? Visibility(
                        child: Padding(
                          padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                          child: Card(
                            elevation: 2,
                            child: ListTile(
                              title: Text("Добавить"),
                              subtitle: Text("Добавить новый рельеф"),
                              leading: Icon(
                                Icons.add,
                                size: 35,
                              ),
                              onTap: () {
                                BlocProvider.of<ReliefBloc>(context).add(ReliefViewUpdateEvent());
                              },
                            ),
                          ),
                        ),
                      )
                    : Container(),
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
                              child: FutureBuilder<String>(
                                  future: ImageRepository.getReliefImage(state.animalList[index].id),
                                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                    if (snapshot.hasData) {
                                      return Image.memory(base64Decode(snapshot.data!), fit: BoxFit.fill);
                                    }
                                    return Image.asset("assets/no-image.jpg");
                                  }),
                            ),
                            subtitle: Text(
                              state.animalList[index].description,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {
                              Navigator.of(context).pushReplacementNamed('/home/book/relief',
                                  arguments: ItemWithRoute(id: state.animalList[index].id, route: '/home/book'));
                            },
                          ),
                        );
                      }),
                ),
              ],
            );
          }
          return Container();
        }),
      ),
    );
  }
}
