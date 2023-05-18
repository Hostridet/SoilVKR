import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../bloc/soil_bloc/soil_bloc.dart';
import '../../repository/SoilRepository.dart';

class SoilComponent extends StatefulWidget {
  const SoilComponent({Key? key}) : super(key: key);

  @override
  State<SoilComponent> createState() => _SoilComponentState();
}

class _SoilComponentState extends State<SoilComponent> {
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
            if (state is SoilLoadedState){
              return Column(
                children: [
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
                                  child: state.soilList[index].image == null
                                      ? DecoratedBox(
                                    decoration: const BoxDecoration(
                                        color: Colors.grey
                                    ),
                                  )
                                      :  Image.memory(base64Decode(state.soilList[index].image!))
                              ),
                              subtitle: Text(
                                  state.soilList[index].name,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () {},

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
