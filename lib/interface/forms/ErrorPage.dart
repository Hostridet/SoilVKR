import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ошибка'),
      ),
      body: Column(
        children: [
          Center(child: Text('Ошибка в навигации')),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed("/");
              },
              child: Text("Обновить")
          ),
        ],
      ),
    );
  }
}
