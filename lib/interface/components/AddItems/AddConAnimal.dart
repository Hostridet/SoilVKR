import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:soil/interface/components/InfoLayout.dart';

import '../../../bloc/plant_bloc/plant_bloc.dart';
import '../../../models/Animal.dart';
import '../../../models/Plant.dart';
import '../../../repository/PlantRepository.dart';

class AddConAnimal extends StatefulWidget {
  const AddConAnimal({Key? key}) : super(key: key);

  @override
  State<AddConAnimal> createState() => _AddConAnimalState();
}

class _AddConAnimalState extends State<AddConAnimal> {
  Plant? currentPlant;
  Animal? currentAnimal;
  Future<bool> _onWillPop() async {
    Navigator.of(context).pushReplacementNamed('/home/admin/plantanimal');
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
                  Navigator.of(context).pushReplacementNamed('/home/admin/plantanimal');
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
                  Text("Растения и животные"),
                ],
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RepositoryProvider(
            create: (context) => PlantRepository(),
            child: BlocProvider<PlantBloc>(
              create: (context) => PlantBloc(RepositoryProvider.of<PlantRepository>(context))..add(PlantAddConAnimalEvent()),
              child: BlocBuilder<PlantBloc, PlantState>(
                builder: (context, state) {
                  if (state is PlantErrorState) {
                    return Center(child: Text(state.error));
                  }
                  if (state is PlantLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is PlantAddConAnimalState) {
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          DropdownSearch<Plant>(
                            popupProps: const PopupProps.bottomSheet(
                              showSearchBox: true,
                            ),
                            dropdownDecoratorProps: const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Растение",
                              ),
                            ),
                            items: state.plantList,
                            onChanged: (Plant? plant) {
                              setState(() {
                                currentPlant = plant!;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          DropdownSearch<Animal>(
                            popupProps: const PopupProps.bottomSheet(
                              showSearchBox: true,
                            ),
                            dropdownDecoratorProps: const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Животное",
                              ),
                            ),
                            items: state.animalList,
                            onChanged: (Animal? animal) {
                              setState(() {
                                currentAnimal = animal!;
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
                                  if (currentPlant == null || currentAnimal == null) {
                                    InfoLayout.buildErrorLayout(context, "Необходимо выбрать растение и животное");
                                    return;
                                  }
                                  int statusCode = await PlantRepository.insertConAnimal(currentPlant!.id, currentAnimal!.id);
                                  if (statusCode != 200) {
                                    InfoLayout.buildErrorLayout(context, "Связь уже существует");
                                    return;
                                  }
                                  Navigator.of(context).pushReplacementNamed('/home/admin/plantanimal');
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
