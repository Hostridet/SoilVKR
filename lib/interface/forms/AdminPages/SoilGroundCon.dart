import 'dart:convert';

import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../bloc/soil_bloc/soil_bloc.dart';
import '../../../repository/ImageRepository.dart';
import '../../../repository/SoilRepository.dart';

class SoilGroundCon extends StatefulWidget {
  const SoilGroundCon({Key? key}) : super(key: key);

  @override
  State<SoilGroundCon> createState() => _SoilGroundConState();
}

class _SoilGroundConState extends State<SoilGroundCon> {
  Future<bool> _onWillPop() async {
    Navigator.of(context)
        .pushReplacementNamed('/home/admin');
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: NewGradientAppBar(
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed('/home/admin');
                },
                icon: Icon(Icons.arrow_back, size: 35,),
              ),
              Row(
                children: [
                  SizedBox(width: 10,),
                  Text("Почва и грунт"),
                ],
              ),
            ],
          ),
          gradient: const LinearGradient(
              colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
        ),
        body: RepositoryProvider(
          create: (context) => SoilRepository(),
          child: BlocProvider<SoilBloc>(
            create: (context) => SoilBloc(
                RepositoryProvider.of<SoilRepository>(context)
            )..add(SoilGetGroundConEvent()),
            child: BlocBuilder<SoilBloc, SoilState>(
              builder: (context, state) {
                if (state is SoilErrorState) {
                  return Center(child: Text(state.error));
                }
                if (state is SoilLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is SoilGroundConState) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: state.soilGroundList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Slidable(
                                  endActionPane: ActionPane(
                                    motion: DrawerMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed:  (_) async {
                                          await SoilRepository.deleteConGround(state.soilGroundList[index].id);
                                          BlocProvider.of<SoilBloc>(context)
                                              .add(SoilGetGroundConEvent());
                                        },
                                        backgroundColor: Color(0xFFFE4A49),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Удалить',
                                      ),
                                    ],
                                  ),
                                  child: Card(
                                    elevation: 2,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 10),
                                        ListTile(
                                          title: Text(
                                              state.soilGroundList[index].soil.name,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                          ),
                                          leading: SizedBox(
                                            width: 100,
                                            height: 200,
                                            child: FutureBuilder<String>(
                                                future: ImageRepository.getSoilImage(state.soilGroundList[index].soil.id),
                                                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Image.memory(base64Decode(snapshot.data!), fit: BoxFit.fill);
                                                  }
                                                  return Container(width: 100, height: 200, decoration: BoxDecoration(color: Color(0xffc7c7c7)));
                                                }
                                            ),
                                          ),
                                        ),
                                        Row(
                                            children: <Widget>[
                                              Expanded(
                                                  child: Divider(
                                                    thickness: 1.0,
                                                  )
                                              ),

                                              Icon(Icons.import_export, color: Colors.green),

                                              Expanded(
                                                  child: Divider(
                                                    thickness: 1.0,
                                                  )
                                              ),
                                            ]
                                        ),
                                        ListTile(
                                          title: Text(
                                              state.soilGroundList[index].ground.name,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                          ),
                                          leading: SizedBox(
                                            width: 100,
                                            height: 200,
                                            child: FutureBuilder<String>(
                                                future: ImageRepository.getGroundImage(state.soilGroundList[index].ground.id),
                                                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Image.memory(base64Decode(snapshot.data!), fit: BoxFit.fill);
                                                  }
                                                  return Container(width: 100, height: 200, decoration: BoxDecoration(color: Color(0xffc7c7c7)));
                                                }
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                );
                              }
                          ),
                        )
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed('/home/admin/soilground/add');
          },
          child: const Icon(Icons.add, color: Colors.white, size: 35),
        ),
      ),
    );
  }
}
