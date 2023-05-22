import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soil/repository/LoginRepository.dart';

import '../../bloc/login_bloc/login_bloc.dart';
import '../components/InfoLayout.dart';
import '../components/InputFieldWidget.dart';
import '../components/LoginButtonWidget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late FocusNode usernameFocus;
  late FocusNode passwordFocus;
  late FocusNode loginBtnFocus;
  late TextEditingController userName;
  late TextEditingController password;

  @override
  void initState() {
    super.initState();
    usernameFocus = FocusNode();
    passwordFocus = FocusNode();
    loginBtnFocus = FocusNode();
    userName = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    usernameFocus.dispose();
    passwordFocus.dispose();
    loginBtnFocus.dispose();
    userName.dispose();
    password.dispose();
    super.dispose();
  }

  clearTextData() {
    userName.clear();
    password.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepositoryProvider(
        create: (context) => LoginRepository(),
        child: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            RepositoryProvider.of<LoginRepository>(context)
          ),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginEmptyState) {
                InfoLayout.buildErrorLayout(context, "Ввдетие логин или пароль");
              }
              if (state is LoginWrongState) {
                InfoLayout.buildErrorLayout(context, "Неверный логин или пароль");
              }
              if (state is LoginLoadedState) {
                clearTextData();
                Navigator.of(context)
                    .pushReplacementNamed('/home');
              }
            },
            builder: (context, state) {
              return buildInitialInput();
            },
          ),
        ),
      ),
    );
  }

  Widget buildInitialInput() => SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(height: 150),
        SvgPicture.asset(
          "assets/logo.svg",
          height: 100,
          width: 100,
        ),
        SizedBox(height: 25),
        InputField(
          focusNode: usernameFocus,
          textController: userName,
          label: "Логин",
          icons: const Icon(Icons.person, color: Colors.green),
        ),
        SizedBox(height: 25),
        InputField(
          focusNode: passwordFocus,
          textController: password,
          label: "Пароль",
          icons: const Icon(Icons.lock, color: Colors.green),
        ),
        SizedBox(height: 25),
        LoginButton(
          focusNode: loginBtnFocus,
          userName: userName,
          password: password,
        ),
        SizedBox(height: 5),
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed('/register');
          },
          child: Text("Зарегистрироваться"),
        ),
      ],
    ),
  );

}
