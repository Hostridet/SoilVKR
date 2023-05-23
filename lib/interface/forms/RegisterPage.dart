import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:soil/interface/components/InfoLayout.dart';
import '../../bloc/register_bloc/register_bloc.dart';
import '../../repository/RegisterRepository.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController emailController;
  late TextEditingController loginController;
  late TextEditingController passwordController;
  late FocusNode emailFocus;
  late FocusNode loginFocus;
  late FocusNode passwordFocus;
  late FocusNode buttonFocus;
  @override
  void initState() {
    super.initState();
    emailFocus = FocusNode();
    loginFocus = FocusNode();
    passwordFocus = FocusNode();
    buttonFocus = FocusNode();
    emailController = TextEditingController();
    loginController = TextEditingController();
    passwordController = TextEditingController();
  }
  @override
  void dispose() {
    emailFocus.dispose();
    loginFocus.dispose();
    passwordFocus.dispose();
    buttonFocus.dispose();
    emailController.dispose();
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: NewGradientAppBar(
        title:  Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed('/login');
              },
              icon: Icon(Icons.arrow_back, size: 35,),
            ),
            Text('Регистрация'),
          ],
        ),
        gradient: const LinearGradient(colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
      ),
      body: RepositoryProvider(
        create: (context) => RegisterRepository(),
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(
              RepositoryProvider.of<RegisterRepository>(context)
          ),
          child: BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccessState) {
                Navigator.of(context)
                    .pushReplacementNamed('/login');
              }
              if (state is RegisterErrorState) {
                InfoLayout.buildErrorLayout(context, state.error);
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(emailFocus);
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color:  Colors.green),
                            borderRadius: BorderRadius.circular(5.5)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color:  Colors.green),
                            borderRadius: BorderRadius.circular(5.5)),
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: "Электронная почта",),
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: loginController,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(loginFocus);
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color:  Colors.green),
                            borderRadius: BorderRadius.circular(5.5)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color:  Colors.green),
                            borderRadius: BorderRadius.circular(5.5)),
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: "Логин",),
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(passwordFocus);
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color:  Colors.green),
                            borderRadius: BorderRadius.circular(5.5)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color:  Colors.green),
                            borderRadius: BorderRadius.circular(5.5)),
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: "Пароль",),
                    ),
                    SizedBox(height: 15,),
                    SizedBox(
                      width: 400,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          onPressed: () async {
                            BlocProvider.of<RegisterBloc>(context)
                                .add(RegisterMakeEvent(emailController.text, loginController.text, passwordController.text));
                          },
                          child: Text("Создать")
                      ),
                    ),
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
