import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soil/models/User.dart';
import '../../../bloc/user_bloc/user_bloc.dart';
import '../../../repository/UserRepository.dart';

class EditUserPage extends StatefulWidget {
  final int id;

  const EditUserPage({Key? key, required this.id}) : super(key: key);

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  List<String> genderList = ["Мужчина", "Женщина"];
  late TextEditingController nameController;
  late TextEditingController surnameController;
  late TextEditingController fatherNameController;
  late FocusNode nameFocus;
  late FocusNode surNameFocus;
  late FocusNode fatherNameFocus;
  late FocusNode buttonFocus;
  late FocusNode ageFocus;
  late TextEditingController ageController;
  late FocusNode emailFocus;
  late TextEditingController emailController;
  late String curGender;

  @override
  void initState() {
    super.initState();
    nameFocus = FocusNode();
    surNameFocus = FocusNode();
    fatherNameFocus = FocusNode();
    buttonFocus = FocusNode();
    nameController = TextEditingController();
    surnameController = TextEditingController();
    fatherNameController = TextEditingController();
    ageFocus = FocusNode();
    ageController = TextEditingController();
    emailFocus = FocusNode();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    nameFocus.dispose();
    surNameFocus.dispose();
    fatherNameFocus.dispose();
    buttonFocus.dispose();
    nameController.dispose();
    surnameController.dispose();
    fatherNameController.dispose();
    ageController.dispose();
    ageFocus.dispose();
    emailFocus.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    Navigator.of(context).pushReplacementNamed('/home/user/all');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/home/user/all');
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 35,
                ),
              ),
              Text('Изменение данных'),
            ],
          ),
        ),
        body: RepositoryProvider(
          create: (context) => UserRepository(),
          child: BlocProvider<UserBloc>(
            create: (context) => UserBloc(RepositoryProvider.of<UserRepository>(context))..add(UserGetByIdEvent(widget.id)),
            child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
              if (state is UserLoadedState) {
                if (state.user.isFemale != null) {
                  curGender = genderList[state.user.isFemale!];
                } else {
                  curGender = genderList.first;
                }
                if (state.user.name != null) {
                  nameController.text = state.user.name!;
                } else {
                  nameController.text = "";
                }
                if (state.user.surname != null) {
                  surnameController.text = state.user.surname!;
                } else {
                  surnameController.text = "";
                }
                if (state.user.fatherName != null) {
                  fatherNameController.text = state.user.fatherName!;
                } else {
                  fatherNameController.text = "";
                }
                if (state.user.age != null) {
                  ageController.text = state.user.age.toString();
                } else {
                  ageController.text = "";
                }
                emailController.text = state.user.email;
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(nameFocus);
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green), borderRadius: BorderRadius.circular(5.5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green), borderRadius: BorderRadius.circular(5.5)),
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: "Имя",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: TextFormField(
                          controller: surnameController,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(surNameFocus);
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.green), borderRadius: BorderRadius.circular(5.5)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.green), borderRadius: BorderRadius.circular(5.5)),
                            hintStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.transparent,
                            hintText: "Фамилия",
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: fatherNameController,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(fatherNameFocus);
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green), borderRadius: BorderRadius.circular(5.5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green), borderRadius: BorderRadius.circular(5.5)),
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: "Отчество",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: TextFormField(
                          controller: ageController,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(ageFocus);
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.green), borderRadius: BorderRadius.circular(5.5)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.green), borderRadius: BorderRadius.circular(5.5)),
                            hintStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.transparent,
                            hintText: "Возраст",
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(emailFocus);
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green), borderRadius: BorderRadius.circular(5.5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green), borderRadius: BorderRadius.circular(5.5)),
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: "Электронная почта",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownSearch(
                        popupProps: const PopupProps.menu(
                          showSearchBox: false,
                          showSelectedItems: false,
                        ),
                        selectedItem: curGender,
                        items: genderList,
                        onChanged: (value) {
                          curGender = value!;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 400,
                        height: 40,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                            onPressed: () async {
                              BlocProvider.of<UserBloc>(context).add(UserUpdateEvent(User(
                                  id: 0,
                                  login: "login",
                                  name: nameController.text,
                                  surname: surnameController.text,
                                  fatherName: fatherNameController.text,
                                  age: int.parse(ageController.text),
                                  isAdmin: 0,
                                  isFemale: genderList.indexOf(curGender),
                                  email: emailController.text)));
                              await Future.delayed(const Duration(seconds: 1));
                              await Navigator.of(context).pushReplacementNamed('/home/user/all');
                            },
                            child: Text("Сохранить")),
                      ),
                    ],
                  ),
                );
              }
              return Container();
            }),
          ),
        ),
      ),
    );
  }
}
