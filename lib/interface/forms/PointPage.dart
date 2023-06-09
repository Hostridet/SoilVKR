import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soil/repository/AdminRepository.dart';
import '../../bloc/point_bloc/point_bloc.dart';
import '../../models/PointWithRoute.dart';
import '../../repository/PointRepository.dart';
import '../components/Drawer.dart';

class PointPage extends StatefulWidget {
  const PointPage({Key? key}) : super(key: key);

  @override
  State<PointPage> createState() => _PointPageState();
}

class _PointPageState extends State<PointPage> {
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
              if (state is PointLoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is PointLoadedState) {
                return RefreshIndicator(
                  onRefresh: () async {
                    return BlocProvider.of<PointBloc>(context)
                        .add(PointGetEvent());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        state.isAdmin == true
                        ? Card(
                          elevation: 2,
                          child: ListTile(
                            leading: Icon(Icons.add, size: 35,),
                            title: Text("Добавить"),
                            subtitle: Text("Добавиь новую территорию"),
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/home/points/add', arguments: '/home/points');
                            },
                          ),
                        )
                         : Container(),
                        Expanded(
                          child: ListView.builder(
                              itemCount: state.pointList.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 2,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed('/home/points/one', arguments: PointWithRoute(point: state.pointList[index], route: '/home/points'));

                                    },
                                    trailing: IconButton(
                                      icon: Icon(Icons.place, color: Colors.red, size: 30,),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed('/home/points/map', arguments: state.pointList[index]);

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
                                        Text("${state.pointList[index].x.toStringAsFixed(7)} ${state.pointList[index].y.toStringAsFixed(7)}"),
                                      ],
                                    ),
                                  ),
                                );
                              }
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
      ),
    );
  }
}
