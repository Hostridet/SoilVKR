import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

import '../components/Drawer.dart';

class InfoBook extends StatefulWidget {
  const InfoBook({Key? key}) : super(key: key);

  @override
  State<InfoBook> createState() => _InfoBookState();
}

class _InfoBookState extends State<InfoBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: NewGradientAppBar(
        title: const Text('База знаний'),
        gradient: const LinearGradient(colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
      ),
      body: Center(child: Text("текст"),),
    );
  }
}