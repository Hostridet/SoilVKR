import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import '../../bloc/point_bloc/point_bloc.dart';
import '../../repository/PointRepository.dart';
import '../components/Drawer.dart';

class PointPage extends StatefulWidget {
  const PointPage({Key? key}) : super(key: key);

  @override
  State<PointPage> createState() => _PointPageState();
}

class _PointPageState extends State<PointPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      appBar:NewGradientAppBar(
        title: const Text('Территории'),
        gradient: const LinearGradient(colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
      ),
      body: RepositoryProvider(
        create: (context) => PointRepository(),
        child: BlocProvider(
          create: (context) =>
          PointBloc(
              RepositoryProvider.of<PointRepository>(context)
          )..add(PointGetEvent()),
          child: BlocBuilder<PointBloc, PointState>(
            builder: (context, state) {
              if (state is PointErrorState) {
                return Center(
                  child: Text(state.error),
                );
              }
              if (state is PointLoadedState) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: state.pointList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 2,
                                child: ListTile(
                                  onTap: () {

                                  },
                                  trailing: IconButton(
                                    icon: Icon(Icons.place, color: Colors.red, size: 30,),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed('/home/points/one', arguments: state.pointList[index]);

                                    },
                                  ),
                                  title: state.pointList[index].address != null
                                    ? Text(
                                      state.pointList[index].address!,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                  )
                                    : Text("Неизвестно"),
                                  subtitle: Row(
                                    children: [
                                      Text(state.pointList[index].x.toString()),
                                      SizedBox(width: 10,),
                                      Text(state.pointList[index].y.toString()),
                                    ],
                                  ),
                                ),
                              );
                            }
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
    );
  }
}