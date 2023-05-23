import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cur_plant_bloc/cur_plant_bloc.dart';
import '../../repository/PlantRepository.dart';

class CurrentPlantPage extends StatefulWidget {
  final int id;
  CurrentPlantPage({Key? key, required this.id}) : super(key: key);

  @override
  State<CurrentPlantPage> createState() => _CurrentPlantPageState();
}

class _CurrentPlantPageState extends State<CurrentPlantPage> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PlantRepository(),
      child: BlocProvider<CurPlantBloc>(
        create: (context) => CurPlantBloc(
            RepositoryProvider.of<PlantRepository>(context)
        )..add(CurPlantGetEvent(widget.id)),
        child: BlocBuilder<CurPlantBloc, CurPlantState>(
          builder: (context, state) {
            if (state is CurPlantErrorState) {
              return Scaffold(
                appBar: NewGradientAppBar(
                  title:  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/home/book');
                        },
                        icon: Icon(Icons.arrow_back, size: 35,),
                      ),
                      Text("Ошибка"),
                    ],
                  ),
                  gradient: const LinearGradient(colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
                ),
                body: Center(
                  child: Text(state.error),
                ),
              );
            }
            if (state is CurPlantLoadedState) {
              return Scaffold(
                appBar: NewGradientAppBar(
                  title:  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/home/book');
                        },
                        icon: Icon(Icons.arrow_back, size: 35,),
                      ),
                      Text(state.plant.name),
                    ],
                  ),
                  gradient: const LinearGradient(colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                              width: double.infinity,
                              height: 250,
                              child: FittedBox(child: Image.memory(base64Decode(state.plant.image!)), fit: BoxFit.fill)
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  padding: EdgeInsets.only(top: 210, left: 10),
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    state.plant.name,
                                    style: TextStyle(color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.0),
                                  )),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(state.plant.description),
                          subtitle: Text("Описание"),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.isFodder != null
                                  ? state.plant.isFodder == 0 ? "Нет" : "Да"
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Является кормовым"),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.isExacting != null
                                  ? state.plant.isExacting == 0 ? "Нет" : "Да"
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Необходим солнечный свет"),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.isOneYears != null
                                  ? state.plant.isOneYears == 0 ? "Нет" : "Да"
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Однолетнее"),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.isTwoYears != null
                                  ? state.plant.isTwoYears == 0 ? "Нет" : "Да"
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Двухлетнее"),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.isManyYears != null
                                  ? state.plant.isManyYears == 0 ? "Нет" : "Да"
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Многолетнее"),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.climat != null
                                  ? state.plant.climat!
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Климат"),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.minTemp != null
                              ? "${state.plant.minTemp} °C"
                              : "Отсутствует"
                          ),
                          subtitle: Text("Минимальная температура"),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.maxTemp != null
                                  ? "${state.plant.maxTemp} °C"
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Максимальная температура"),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.kingdom != null
                              ? state.plant.kingdom!
                              : "Отсутствует"
                          ),
                          subtitle: Text("Царство"),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.philum != null
                                  ? state.plant.philum!
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Тип"),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.classes != null
                                  ? state.plant.classes!
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Класс"),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.order != null
                                  ? state.plant.order!
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Отряд"),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.family != null
                                  ? state.plant.family!
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Семейство"),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.genus != null
                                  ? state.plant.genus!
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Род"),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(
                              state.plant.species != null
                                  ? state.plant.species!
                                  : "Отсутствует"
                          ),
                          subtitle: Text("Вид"),
                        ),
                      ),


                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

}
