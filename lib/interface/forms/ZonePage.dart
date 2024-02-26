import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/zone_bloc/zone_bloc.dart';
import '../../repository/ZoneRepository.dart';

class ZonePage extends StatefulWidget {
  final List coords;
  ZonePage({Key? key, required this.coords}) : super(key: key);

  @override
  State<ZonePage> createState() => _ZonePageState();
}

class _ZonePageState extends State<ZonePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/home');
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 35,
                ),
              ),
              Text('Данные о локации'),
            ],
          ),
        ),
        body: RepositoryProvider(
          create: (context) => ZoneRepository(),
          child: BlocProvider<ZoneBloc>(
            create: (context) =>
                ZoneBloc(RepositoryProvider.of<ZoneRepository>(context))..add(ZoneGetEvent(widget.coords[0], widget.coords[1])),
            child: BlocBuilder<ZoneBloc, ZoneState>(builder: (context, state) {
              if (state is ZoneErrorState) {
                Center(
                  child: Text(state.error),
                );
              }
              if (state is ZoneLoadedState) {
                print(state.zone);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView(
                        children: [
                          Card(
                            elevation: 1,
                            child: ListTile(
                              leading: Icon(Icons.terrain, color: Colors.brown),
                              title: Text(state.zone.soil_name),
                              subtitle: Text(
                                state.zone.soil_description,
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () {},
                            ),
                          ),
                          Card(
                            elevation: 1,
                            child: ListTile(
                              leading: Icon(Icons.grass, color: Colors.green),
                              title: Text(state.zone.plant_name),
                              subtitle: Text(
                                state.zone.plant_description,
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () {},
                            ),
                          ),
                          Card(
                            elevation: 1,
                            child: ListTile(
                              leading: Icon(Icons.pets, color: Colors.pink),
                              title: Text(state.zone.animal_name),
                              subtitle: Text(
                                state.zone.animal_description,
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () {},
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                );
              }
              return Container();
            }),
          ),
        ));
  }
}
