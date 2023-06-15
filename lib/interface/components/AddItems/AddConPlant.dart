import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:soil/interface/components/InfoLayout.dart';

import '../../../bloc/soil_bloc/soil_bloc.dart';
import '../../../models/Ground.dart';
import '../../../models/Plant.dart';
import '../../../models/Soil.dart';
import '../../../repository/SoilRepository.dart';
class AddConPlant extends StatefulWidget {
  const AddConPlant({Key? key}) : super(key: key);

  @override
  State<AddConPlant> createState() => _AddConPlantState();
}

class _AddConPlantState extends State<AddConPlant> {
  Soil? currentSoil;
  Plant? currentPlant;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed('/home/admin/soilplant');
              },
              icon: Icon(Icons.arrow_back, size: 35,),
            ),
            Row(
              children: [
                SizedBox(width: 10,),
                Text("Почвы и растения"),
              ],
            ),
          ],
        ),
        gradient: const LinearGradient(
            colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RepositoryProvider(
          create: (context) => SoilRepository(),
          child: BlocProvider<SoilBloc>(
            create: (context) => SoilBloc(
                RepositoryProvider.of<SoilRepository>(context)
            )..add(SoilAddConPlantEvent()),
            child: BlocBuilder<SoilBloc, SoilState>(
              builder: (context, state) {
                if (state is SoilErrorState) {
                  return Center(child: Text(state.error));
                }
                if (state is SoilLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is SoilAddConPlantState) {
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        DropdownSearch<Soil>(
                          mode: Mode.BOTTOM_SHEET,
                          searchFieldProps: const TextFieldProps(
                            cursorColor: Colors.green,
                          ),
                          dropdownSearchDecoration: InputDecoration(
                              labelText: "Почва"
                          ),
                          items: state.soilList,
                          showSearchBox: true,
                          onChanged: (Soil? soil) {
                            setState(() {
                              currentSoil = soil!;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        DropdownSearch<Plant>(
                          mode: Mode.BOTTOM_SHEET,
                          searchFieldProps: const TextFieldProps(
                            cursorColor: Colors.green,
                          ),
                          dropdownSearchDecoration: InputDecoration(
                              labelText: "Растение"
                          ),
                          items: state.plantList,
                          showSearchBox: true,
                          onChanged: (Plant? plant) {
                            setState(() {
                              currentPlant = plant!;
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
                                if (currentPlant == null || currentSoil == null) {
                                  InfoLayout.buildErrorLayout(context, "Необходимо выбрать почву и растение");
                                  return;
                                }
                                int statusCode = await SoilRepository.insertConPlant(currentSoil!.id, currentPlant!.id);
                                if (statusCode != 200) {
                                  InfoLayout.buildErrorLayout(context, "Связь уже существует");
                                  return;
                                }
                                Navigator.of(context)
                                    .pushReplacementNamed('/home/admin/soilplant');
                              },
                              child: Text("Добавить")
                          ),
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
    );
  }
}
