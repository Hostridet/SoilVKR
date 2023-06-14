import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../bloc/user_bloc/user_bloc.dart';
import '../../../models/User.dart';
import '../../../repository/UserRepository.dart';

class AllUserPage extends StatefulWidget {
  const AllUserPage({Key? key}) : super(key: key);

  @override
  State<AllUserPage> createState() => _AllUserPageState();
}

class _AllUserPageState extends State<AllUserPage> {
  List<User> items = [];
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed('/home/admin');
              },
              icon: Icon(Icons.arrow_back, size: 35,),
            ),
            Row(
              children: [
                SizedBox(width: 10,),
                Text("Список пользователей"),
              ],
            ),
          ],
        ),
        gradient: const LinearGradient(
            colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
      ),
      body: RepositoryProvider(
        create: (context) => UserRepository(),
        child: BlocProvider<UserBloc>(
          create: (context) => UserBloc(
              RepositoryProvider.of<UserRepository>(context)
          )..add(UserGetAllEvent()),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is UserLoadedAllState) {
                if (items.isEmpty) {
                  items.addAll(state.userList);
                }
                return Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        TextField(
                          onChanged: (value) {
                            filterSearchResults(value.toLowerCase(), state.userList);
                          },
                          controller: editingController,
                          decoration: const InputDecoration(
                            labelText: "Поиск",
                            hintText: "Поиск",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                          ),
                        ),
                        Expanded(
                            child: ListView.builder(
                                itemCount: items.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 2,
                                    child: ListTile(
                                      trailing: Icon(Icons.edit),
                                      title: Text("${items[index].surname} ${items[index].name} ${items[index].fatherName}"),
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed('/home/admin/users/edit', arguments: items[index].id);
                                      },
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
            }
          ),
        ),
      ),
    );
  }
  void filterSearchResults(String query, List<User> userList) {
    List<User> dummySearchList = [];
    dummySearchList.addAll(userList);

    if(query.isNotEmpty) {
      List<User> dummyListData = [];
      dummySearchList.forEach((item) {
        if("${item.name} ${item.surname} ${item.fatherName}".toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(userList);
      });
    }

  }
}
