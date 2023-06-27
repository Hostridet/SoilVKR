import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../bloc/soil_bloc/soil_bloc.dart';
import '../../models/ItemWithRoute.dart';
import '../../repository/ImageRepository.dart';
import '../../repository/SoilRepository.dart';
import 'InfoLayout.dart';

class SoilComponent extends StatefulWidget {
  const SoilComponent({Key? key}) : super(key: key);

  @override
  State<SoilComponent> createState() => _SoilComponentState();
}

class _SoilComponentState extends State<SoilComponent> {
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
      create: (context) => SoilRepository(),
      child: BlocProvider<SoilBloc>(
        create: (context) => SoilBloc(
            RepositoryProvider.of<SoilRepository>(context)
        )..add(SoilGetEvent()),
        child: BlocBuilder<SoilBloc, SoilState>(
          builder: (context, state) {
            if (state is SoilErrorState) {
              return Center(
                child: Text(state.error),
              );
            }
            if (state is SoilLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is SoilViewUpdateState) {
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
                        hintText: "Название почвы",),
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
                        hintText: "Описание почвы",),
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
                              BlocProvider.of<SoilBloc>(context)
                                  .add(SoilGetEvent());
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
                              BlocProvider.of<SoilBloc>(context)
                                  .add(SoilUpdateEvent(nameController.text, descriptionController.text));
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
            if (state is SoilLoadedState){
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
                          subtitle: Text("Добавить новую почву"),
                          leading: Icon(Icons.add, size: 35,),
                          onTap: () {
                            BlocProvider.of<SoilBloc>(context)
                                .add(SoilViewUpdateEvent());
                          },
                        ),
                    ),
                  ),
                      )
                      : Container(),
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
                                  child: FutureBuilder<String>(
                                      future: ImageRepository.getSoilImage(state.soilList[index].id),
                                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                        if (snapshot.hasData) {
                                          return Image.memory(base64Decode(snapshot.data!), fit: BoxFit.fill);
                                        }
                                        return Image.asset("assets/no-image.jpg");
                                      }
                                  ),
                              ),
                              subtitle: Text(
                                  state.soilList[index].name,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/home/book/soil', arguments: ItemWithRoute(id: state.soilList[index].id, route: '/home/book'));
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
