import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../bloc/ground_bloc/ground_bloc.dart';
import '../../repository/GroundRepository.dart';
import '../../repository/ImageRepository.dart';

class GroundComponent extends StatefulWidget {
  const GroundComponent({Key? key}) : super(key: key);

  @override
  State<GroundComponent> createState() => _GroundComponentState();
}

class _GroundComponentState extends State<GroundComponent> {
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
                    state.isAdmin == true
                        ? Visibility(
                          visible: isShow,
                          child: Padding(
                      padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                      child: Card(
                          elevation: 2,
                          child: ListTile(
                            title: Text("Добавить"),
                            subtitle: Text("Добавить новый грунт"),
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
                                          return Container(decoration: BoxDecoration(color: Color(0xffc7c7c7)));
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
