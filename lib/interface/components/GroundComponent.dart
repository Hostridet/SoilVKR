import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../bloc/ground_bloc/ground_bloc.dart';
import '../../repository/GroundRepository.dart';

class GroundComponent extends StatefulWidget {
  const GroundComponent({Key? key}) : super(key: key);

  @override
  State<GroundComponent> createState() => _GroundComponentState();
}

class _GroundComponentState extends State<GroundComponent> {
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
              if (state is GroundLoadedState){
                return Column(
                  children: [
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
                                    child: state.groundList[index].image == null
                                        ? DecoratedBox(
                                      decoration: const BoxDecoration(
                                          color: Colors.grey
                                      ),
                                    )
                                        :  Image.memory(base64Decode(state.groundList[index].image!), fit: BoxFit.fill,)
                                ),
                                subtitle: Text(
                                  state.groundList[index].description,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/home/book/ground', arguments: state.groundList[index].id);
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