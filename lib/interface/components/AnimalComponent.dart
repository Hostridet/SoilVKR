import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soil/repository/ImageRepository.dart';

import '../../bloc/animal_bloc/animal_bloc.dart';
import '../../models/ItemWithRoute.dart';
import '../../repository/AnimalRepository.dart';

class AnimalComponent extends StatefulWidget {
  const AnimalComponent({Key? key}) : super(key: key);

  @override
  State<AnimalComponent> createState() => _AnimalComponentState();
}

class _AnimalComponentState extends State<AnimalComponent> {
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
      create: (context) => AnimalRepository(),
      child: BlocProvider<AnimalBloc>(
        create: (context) => AnimalBloc(
            RepositoryProvider.of<AnimalRepository>(context)
        )..add(AnimalGetEvent()),
        child: BlocBuilder<AnimalBloc, AnimalState>(
          builder: (context, state) {
            if (state is AnimalErrorState) {
              return Center(
                child: Text(state.error),
              );
            }
            if (state is AnimalLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is AnimalViewUpdateState) {
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
                        hintText: "Название животного",),
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
                        hintText: "Описание животного",),
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
                              BlocProvider.of<AnimalBloc>(context)
                                  .add(AnimalGetEvent());
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
                              BlocProvider.of<AnimalBloc>(context)
                                  .add(AnimalUpdateEvent(nameController.text, descriptionController.text));
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
            if (state is AnimalLoadedState) {
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
                          subtitle: Text("Добавить новое животное"),
                          leading: Icon(Icons.add, size: 35,),
                          onTap: () {
                            BlocProvider.of<AnimalBloc>(context)
                                .add(AnimalViewUpdateEvent());
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
                                    future: ImageRepository.getAnimalImage(state.animalList[index].id),
                                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                        if (snapshot.hasData) {
                                          return Image.memory(base64Decode(snapshot.data!), fit: BoxFit.fill);
                                        }
                                        return Container(width: 100, height: 200, decoration: BoxDecoration(color: Color(0xffc7c7c7)));
                                      }
                                  ),
                              ),
                              subtitle: Text(
                                  state.animalList[index].description,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/home/book/animal', arguments: ItemWithRoute(id: state.animalList[index].id, route: '/home/book'));
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
