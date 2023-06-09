import 'dart:convert';

import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soil/interface/components/UserDialog.dart';
import 'package:soil/interface/components/Drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soil/interface/components/InputFieldWidget.dart';

import '../../bloc/user_bloc/user_bloc.dart';
import '../../repository/ImageRepository.dart';
import '../../repository/UserRepository.dart';
import '../components/DisplayImage.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: NewGradientAppBar(
        title: const Text('Пользователь'),
        gradient: const LinearGradient(
            colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
      ),
      body: RepositoryProvider(
        create: (context) => UserRepository(),
        child: BlocProvider<UserBloc>(
          create: (context) => UserBloc(
              RepositoryProvider.of<UserRepository>(context)
          )..add(UserGetEvent()),
          child:BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is UserLoadedState) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<UserBloc>(context)
                          .add(UserGetEvent());
                    },
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await ImageRepository.uploadImage();
                              },
                              child: Container(
                                  height: 150,
                                  width: 150,
                                  child: FutureBuilder<String>(
                                    future: ImageRepository.getUserImage(state.user.id),
                                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                      if (snapshot.hasData) {
                                        return DisplayImage(image: snapshot.data!);
                                      }
                                      else {
                                        return DisplayImage(loadingImage: 'assets/user.png');

                                      }},
                                  )
                              ),
                            ),
                            SizedBox(height: 20),
                            Card(
                              elevation: 2,
                              child: ListTile(
                                trailing: Icon(Icons.chevron_right),
                                title: Text(
                                    state.user.name != null
                                    ? "${state.user.surname} ${state.user.name} ${state.user.fatherName}"
                                    : "Неизвестно"
                                ),
                                subtitle: Text("ФИО"),
                                leading: Icon(
                                  Icons.person, size: 35, color: Colors.orange,),
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/home/user/edit');
                                },
                              ),
                            ),
                            Card(
                              elevation: 2,
                              child: ListTile(
                                trailing: Icon(Icons.chevron_right),
                                title: Text(
                                    state.user.age != null
                                    ? "${state.user.age}"
                                    : "Неизвестно"
                                ),
                                subtitle: Text("Возраст"),
                                leading: Icon(
                                  Icons.accessibility_new, size: 35, color: Colors.purple,),
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/home/user/edit');
                                },
                              ),
                            ),
                            Card(
                              elevation: 2,
                              child: ListTile(
                                trailing: Icon(Icons.chevron_right),
                                title: state.user.isFemale != null
                                ? state.user.isFemale == 0 ? Text("Мужчина") : Text("Женщина")
                                : Text("Неизвестно")
                                ,
                                subtitle: Text("Пол"),
                                leading: Icon(
                                  Icons.face, size: 35, color: Colors.green,),
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/home/user/edit');
                                },
                              ),
                            ),
                            Card(
                              elevation: 2,
                              child: ListTile(
                                trailing: Icon(Icons.chevron_right),
                                title: Text(state.user.email),
                                subtitle: Text("Электронная почта"),
                                leading: Icon(Icons.mail, size: 35, color: Colors.blue,),
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/home/user/edit');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return Container();
              }
          ),
        ),
      ),
    );
  }
}
