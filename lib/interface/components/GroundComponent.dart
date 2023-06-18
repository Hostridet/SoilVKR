import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soil/interface/components/InfoLayout.dart';

import '../../bloc/ground_bloc/ground_bloc.dart';
import '../../models/ItemWithRoute.dart';
import '../../repository/GroundRepository.dart';
import '../../repository/ImageRepository.dart';

class GroundComponent extends StatefulWidget {
  const GroundComponent({Key? key}) : super(key: key);

  @override
  State<GroundComponent> createState() => _GroundComponentState();
}

class _GroundComponentState extends State<GroundComponent> {
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
      create: (context) => GroundRepository(),
      child: BlocProvider<GroundBloc>(
        create: (context) => GroundBloc(
            RepositoryProvider.of<GroundRepository>(context)
        )..add(GroundGetEvent()),
        child: BlocBuilder<GroundBloc, GroundState>(
            builder: (context, state) {
              if (state is GroundErrorState) {
                return Center(
                  child: Text(state.error),
                );
              }
              if (state is GroundLoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is GroundViewUpdateState) {
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
                          hintText: "Название грунта",),
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
                          hintText: "Описание грунта",),
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
                                BlocProvider.of<GroundBloc>(context)
                                    .add(GroundGetEvent());
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
                                BlocProvider.of<GroundBloc>(context)
                                    .add(GroundUpdateEvent(nameController.text, descriptionController.text));
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
              if (state is GroundLoadedState){
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
                            subtitle: Text("Добавить новый грунт"),
                            leading: Icon(Icons.add, size: 35,),
                            onTap: () {
                              BlocProvider.of<GroundBloc>(context)
                                  .add(GroundViewUpdateEvent());
                            },
                          ),
                      ),
                    ),
                        )
                        : Container(),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.groundList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              elevation: 2,
                              child: ListTile(
                                title: Text(
                                  state.groundList[index].name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                leading: SizedBox(
                                    width: 100,
                                    height: 200,
                                    child: FutureBuilder<String>(
                                        future: ImageRepository.getGroundImage(state.groundList[index].id),
                                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                          if (snapshot.hasData) {
                                            return Image.memory(base64Decode(snapshot.data!), fit: BoxFit.fill);
                                          }
                                          return Image.asset("assets/no-image.jpg");
                                        }
                                    ),
                                ),
                                subtitle: Text(
                                  state.groundList[index].description,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/home/book/ground', arguments: ItemWithRoute(id: state.groundList[index].id, route: '/home/book'));
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
            }
        ),
      ),
    );
  }
}
