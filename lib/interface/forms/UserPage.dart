import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soil/interface/components/UserDialog.dart';
import 'package:soil/interface/components/Drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soil/interface/components/InputFieldWidget.dart';

import '../../bloc/user_bloc/user_bloc.dart';
import '../../repository/UserRepository.dart';

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
                if (state is UserLoadedState) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          // SizedBox(
                          //   width: double.infinity,
                          //   height: 100,
                          //   child: Card(
                          //     elevation: 1,
                          //     child: Row(
                          //       children: [
                          //         Container(
                          //             margin: EdgeInsets.only(left: 15),
                          //             height: 80,
                          //             width: 80,
                          //             child: CircleAvatar(
                          //                 backgroundColor: Colors.white,
                          //                 child: ClipRRect(
                          //                   borderRadius:BorderRadius.circular(50),
                          //                   child: Image.asset("assets/user.png"),
                          //                 )
                          //             )
                          //         ),
                          //         Padding(
                          //           padding: const EdgeInsets.only(left: 20.0),
                          //           child: Text("Никита", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          Card(
                            elevation: 2,
                            child: ListTile(
                              title: Text("${state.user.surname} ${state.user.name} ${state.user.fatherName}"),
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
                              title: state.user.isFemale == 0
                              ? Text("Мужчина")
                              : Text("Женщина")
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
