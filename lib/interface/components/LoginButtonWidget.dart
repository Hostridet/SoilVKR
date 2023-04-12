import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soil/bloc/login_bloc/login_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton(
      {Key? key,
        required this.focusNode,
        required this.userName,
        required this.password})
      : super(key: key);

  final FocusNode focusNode;
  final TextEditingController userName;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.00),
      child: OutlinedButton(
        focusNode: focusNode,
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.green, width: 1),
            minimumSize: const Size(double.infinity, 54),
            backgroundColor:  Colors.green),
        onPressed: () {
          BlocProvider.of<LoginBloc>(context)
              .add(LoginUser(userName.text, password.text));
        },
        child: const Text(
          'Войти',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}