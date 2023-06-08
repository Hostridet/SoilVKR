import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/point_bloc/point_bloc.dart';
import '../../models/Point.dart';
import '../../models/PointWithRoute.dart';
import '../../repository/PointRepository.dart';

class CurrentPointPage extends StatefulWidget {
  final PointWithRoute args;
  const CurrentPointPage({Key? key, required this.args}) : super(key: key);

  @override
  State<CurrentPointPage> createState() => _CurrentPointPageState();
}

class _CurrentPointPageState extends State<CurrentPointPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(widget.args.route);
              },
              icon: Icon(Icons.arrow_back, size: 35,),
            ),
            Row(
              children: [
                SizedBox(width: 10,),
                Text("${widget.args.point.x.toStringAsFixed(7)} ${widget.args.point.y.toStringAsFixed(7)}"),
              ],
            ),
          ],
        ),
        gradient: const LinearGradient(
            colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
      ),
      body: RepositoryProvider(
        create: (context) => PointRepository(),
        child: BlocProvider<PointBloc>(
          create: (context) => PointBloc(
              RepositoryProvider.of<PointRepository>(context)
          )..add(PointGetOneEvent(widget.args.point.id)),
          child: BlocBuilder<PointBloc, PointState>(
            builder: (context, state) {
              if (state is PointLoadedOneState) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: Row(
                            children: [
                              Text("${state.point.x.toStringAsFixed(7)} ${state.point.y.toStringAsFixed(7)}"),
                            ],
                          ),
                          subtitle: Text("Координаты"),
                        ),
                        Divider(),
                        ListTile(
                          title: state.point.address != null
                            ? Text(state.point.address!)
                            : Text("Неизвестно"),
                          subtitle: Text("Адрес"),
                        ),
                        Divider(),
                        SizedBox(height: 20,),
                        Card(
                          elevation: 2,
                          child: ListTile(
                            leading: Icon(Icons.south_america, color: Colors.orangeAccent, size: 35,),
                            title: Text("Почвы"),
                            subtitle: Text("Список почв"),
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/home/points/soil', arguments: PointWithRoute(point: state.point, route: widget.args.route));

                            },
                          ),
                        ),
                        Card(
                          elevation: 2,
                          child: ListTile(
                            leading: Icon(Icons.pets, color: Colors.pink, size: 35),
                            title: Text("Животные"),
                            subtitle: Text("Список животных"),
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/home/points/animal', arguments: PointWithRoute(point: state.point, route: widget.args.route));

                            },
                          ),
                        ),
                        Card(
                          elevation: 2,
                          child: ListTile(
                            leading: Icon(Icons.grass, color: Colors.green, size: 35),
                            title: Text("Растения"),
                            subtitle: Text("Список растений"),
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/home/points/plant', arguments: PointWithRoute(point: state.point, route: widget.args.route));

                            },
                          ),
                        ),
                        Card(
                          elevation: 2,
                          child: ListTile(
                            leading: Icon(Icons.terrain, color: Colors.brown, size: 35),
                            title: Text("Грунты"),
                            subtitle: Text("Список грунтов"),
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/home/points/ground', arguments: PointWithRoute(point: state.point, route: widget.args.route));
                            },
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
