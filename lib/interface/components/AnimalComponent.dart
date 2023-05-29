import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/animal_bloc/animal_bloc.dart';
import '../../repository/AnimalRepository.dart';

class AnimalComponent extends StatefulWidget {
  const AnimalComponent({Key? key}) : super(key: key);

  @override
  State<AnimalComponent> createState() => _AnimalComponentState();
}

class _AnimalComponentState extends State<AnimalComponent> {
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
            if (state is AnimalLoadedState) {
              return Column(
                children: [
                  state.isAdmin == true
                      ? Padding(
                    padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                    child: Card(
                      elevation: 2,
                      child: ListTile(
                        title: Text("Добавить"),
                        subtitle: Text("Добавить новое животное"),
                        leading: Icon(Icons.add, size: 35,),
                        onTap: () {
                        },
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
          }
        ),
      ),
    );
  }
}
