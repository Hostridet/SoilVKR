import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:soil/interface/components/InfoLayout.dart';
import 'package:soil/models/Climat.dart';
import 'package:soil/models/Foundation.dart';
import 'package:soil/models/Water.dart';

import '../../../bloc/soil_bloc/soil_bloc.dart';
import '../../../models/Soil.dart';
import '../../../models/Point.dart';
import '../../../repository/SoilRepository.dart';

class AddConWater extends StatefulWidget {
  const AddConWater({Key? key}) : super(key: key);

  @override
  State<AddConWater> createState() => _AddConPointState();
}

class _AddConPointState extends State<AddConWater> {
  Water? currentSoil;
  Point? currentPoint;
  Future<bool> _onWillPop() async {
    Navigator.of(context).pushReplacementNamed('/home/admin/locationwater');
    return false;
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
                  Navigator.of(context).pushReplacementNamed('/home/admin/locationwater');
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
              create: (context) => SoilBloc(RepositoryProvider.of<SoilRepository>(context))..add(WaterAddGetPointConEvent()),
              child: BlocBuilder<SoilBloc, SoilState>(
                builder: (context, state) {
                  if (state is SoilErrorState) {
                    return Center(child: Text(state.error));
                  }
                  if (state is SoilLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is WaterPointAddConState) {
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          DropdownSearch<Water>(
                            popupProps: const PopupProps.bottomSheet(
                              showSearchBox: true,
                            ),
                            dropdownDecoratorProps: const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Воды",
                              ),
                            ),
                            items: state.waterList,
                            onChanged: (Water? soil) {
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
                                    InfoLayout.buildErrorLayout(context, "Необходимо выбрать воды и территорию");
                                    return;
                                  }
                                  int statusCode = await SoilRepository.insertConWater(currentSoil!.id, currentPoint!.id);
                                  if (statusCode != 200) {
                                    InfoLayout.buildErrorLayout(context, "Связь уже существует");
                                    return;
                                  }
                                  Navigator.of(context).pushReplacementNamed('/home/admin/locationwater');
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
