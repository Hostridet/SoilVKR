import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:soil/interface/components/InfoLayout.dart';
import 'package:soil/models/Climat.dart';
import 'package:soil/models/Foundation.dart';
import 'package:soil/models/Relief.dart';
import 'package:soil/models/Water.dart';

import '../../../bloc/soil_bloc/soil_bloc.dart';
import '../../../models/Soil.dart';
import '../../../models/Point.dart';
import '../../../repository/SoilRepository.dart';

class AddConRelief extends StatefulWidget {
  const AddConRelief({Key? key}) : super(key: key);

  @override
  State<AddConRelief> createState() => _AddConPointState();
}

class _AddConPointState extends State<AddConRelief> {
  Relief? currentSoil;
  Point? currentPoint;

  Future<bool> _onWillPop() async {
    Navigator.of(context).pushReplacementNamed('/home/admin/locationrelief');
    return false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/home/admin/locationrelief');
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 35,
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text("Территория и воды"),
                ],
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RepositoryProvider(
            create: (context) => SoilRepository(),
            child: BlocProvider<SoilBloc>(
              create: (context) => SoilBloc(RepositoryProvider.of<SoilRepository>(context))..add(ReliefAddGetPointConEvent()),
              child: BlocBuilder<SoilBloc, SoilState>(
                builder: (context, state) {
                  if (state is SoilErrorState) {
                    return Center(child: Text(state.error));
                  }
                  if (state is SoilLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is ReliefPointAddConState) {
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          DropdownSearch<Relief>(
                            popupProps: const PopupProps.bottomSheet(
                              showSearchBox: true,
                            ),
                            dropdownDecoratorProps: const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Рельеф",
                              ),
                            ),
                            items: state.reliefList,
                            onChanged: (Relief? soil) {
                              setState(() {
                                currentSoil = soil!;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          DropdownSearch<Point>(
                            popupProps: const PopupProps.bottomSheet(
                              showSearchBox: true,
                            ),
                            dropdownDecoratorProps: const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Территория",
                              ),
                            ),
                            items: state.pointList,
                            onChanged: (Point? point) {
                              setState(() {
                                currentPoint = point!;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                ),
                                onPressed: () async {
                                  if (currentPoint == null || currentSoil == null) {
                                    InfoLayout.buildErrorLayout(context, "Необходимо выбрать рельеф и территорию");
                                    return;
                                  }
                                  int statusCode = await SoilRepository.insertConRelief(currentSoil!.id, currentPoint!.id);
                                  if (statusCode != 200) {
                                    InfoLayout.buildErrorLayout(context, "Связь уже существует");
                                    return;
                                  }
                                  Navigator.of(context).pushReplacementNamed('/home/admin/locationrelief');
                                },
                                child: Text("Добавить")),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
