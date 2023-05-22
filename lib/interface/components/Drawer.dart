import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soil/repository/UserRepository.dart';

import '../../bloc/user_bloc/user_bloc.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => UserRepository(),
        child: BlocProvider<UserBloc>(
          create: (context) => UserBloc(
              RepositoryProvider.of<UserRepository>(context)
          )..add(UserGetEvent()),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserErrorState) {
                return Drawer(
                  child: Center(child: Text(state.error)),
                );
              }
              if (state is UserLoadedState) {
                return Drawer(
                  child: ListView(
                    padding: const EdgeInsets.all(0.0),
                    children: [
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: Color(0xff228B22),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: ClipRRect(
                                    borderRadius:BorderRadius.circular(50),
                                    child: state.user.image != null
                                        ? Image.memory(base64Decode(state.user.image!))
                                        : Image.asset("assets/user.png"),
                                  )
                              )
                            ),
                            const SizedBox(height: 10),
                            state.user.name != null
                            ? Text(state.user.name!,
                                style: TextStyle(color: Colors.white, fontSize: 16))
                            : Text("Неизвестно",
                                style: TextStyle(color: Colors.white, fontSize: 16)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                state.user.fatherName != null
                                ? Text(state.user.fatherName!,
                                    style: TextStyle(color: Colors.white, fontSize: 16))
                                : Text("Неизвестно",
                                    style: TextStyle(color: Colors.white, fontSize: 16))
                              ],
                            ),
                          ],
                        ),
                      ),

                      ListTile(
                        leading: const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Icon(Icons.map, size: 30, color: Colors.orange),
                        ),
                        title: Text("Главный экран"),
                        subtitle: Text("Главный экран"),
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/home');
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Icon(Icons.bookmarks, size: 30, color: Colors.green),
                        ),
                        title: Text("База знаний"),
                        subtitle: Text("Основные данные"),
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/home/book');
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Icon(Icons.person, size: 30, color: Colors.blue),
                        ),
                        title: Text("Пользователь"),
                        subtitle: Text("Данные о пользователе"),
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/home/user');
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Icon(Icons.settings, size: 30, color: Colors.grey),
                        ),
                        title: Text("Настройки"),
                        subtitle: Text("Настройки приложения"),
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/home/settings');
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Icon(Icons.exit_to_app, size: 30, color: Colors.red),
                        ),
                        title: Text("Выйти"),
                        subtitle: Text("Выйти из аккаунта"),
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/login', (Route<dynamic> route) => false);
                        },
                      ),
                      Divider(),
                    ],
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
