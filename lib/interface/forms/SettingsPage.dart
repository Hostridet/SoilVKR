import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/ligth_bloc/light_bloc.dart';
import '../../bloc/theme_bloc/theme_bloc.dart';
import '../components/Drawer.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  late bool light;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LightBloc>(
      create: (context) => LightBloc()..add(LightGetEvent()),
      child: Scaffold(
        drawer: DrawerMenu(),
        appBar:NewGradientAppBar(
          title: const Text('Настройки'),
          gradient: const LinearGradient(colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
        ),
        body: BlocBuilder<LightBloc, LightState>(
          builder: (context, state) {
            if (state is LightLoadedState) {
              light = state.light;
              return Column(
                children: [
                  ListTile(
                      trailing: Switch(
                        value: light,
                        activeColor: Colors.grey,
                        onChanged: (bool value) async {
                          final prefs =
                          await SharedPreferences.getInstance();
                          setState(() {
                            light = value;
                          });
                          if (light) {
                            BlocProvider.of<ThemeBloc>(context)
                                .add(ThemeSetDarkEvent());
                            prefs.setInt("mode", 1);
                          } else if (!light) {
                            BlocProvider.of<ThemeBloc>(context)
                                .add(ThemeSetEvent());
                            prefs.setInt("mode", 0);
                          }
                          BlocProvider.of<LightBloc>(context)
                              .add(LightGetEvent());
                        },
                      ),
                      leading: const Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Icon(Icons.light_mode, size: 30, color: Colors.grey),
                      ),
                      title: Text("Темная тема"),
                      subtitle: Text("Включить темную тему"),
                  ),
                  Divider(),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
