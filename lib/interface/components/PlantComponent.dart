import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/plant_bloc/plant_bloc.dart';
import '../../repository/ImageRepository.dart';
import '../../repository/PlantRepository.dart';

class PlantComponent extends StatefulWidget {
  const PlantComponent({Key? key}) : super(key: key);

  @override
  State<PlantComponent> createState() => _PlantComponentState();
}

class _PlantComponentState extends State<PlantComponent> {
  bool isShow = true;
  ScrollController _controller = ScrollController();
  @override
  void initState() {
    _controller..addListener(onScroll);
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
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
            if (state is PlantLoadedState) {
              return Column(
                children: [
                  state.isAdmin == true
                  ? Visibility(
                    visible: isShow,
                    child: Padding(
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
  void onScroll() {
    if (_controller.offset == 0.0) {
      setState(() {
        isShow = true;
      });
    }
    else {
      setState(() {
        isShow = false;
      });
    }
  }
}
