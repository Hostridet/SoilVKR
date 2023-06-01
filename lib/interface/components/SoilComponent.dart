import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../bloc/soil_bloc/soil_bloc.dart';
import '../../repository/ImageRepository.dart';
import '../../repository/SoilRepository.dart';

class SoilComponent extends StatefulWidget {
  const SoilComponent({Key? key}) : super(key: key);

  @override
  State<SoilComponent> createState() => _SoilComponentState();
}

class _SoilComponentState extends State<SoilComponent> {
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
                  state.isAdmin == true
                      ? Visibility(
                        visible: isShow,
                        child: Padding(
                    padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                    child: Card(
                        elevation: 2,
                        child: ListTile(
                          title: Text("Добавить"),
                          subtitle: Text("Добавить новую почву"),
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
                                        return Container(decoration: BoxDecoration(color: Color(0xffc7c7c7)));
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
                                    .pushReplacementNamed('/home/book/soil', arguments: state.soilList[index].id);
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
