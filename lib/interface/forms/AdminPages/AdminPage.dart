import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/cupertino.dart';

import '../../components/Drawer.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      appBar:NewGradientAppBar(
        title: const Text('Администрирование'),
        gradient: const LinearGradient(colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Card(
                elevation: 2,
                child: ListTile(
                  trailing: Icon(Icons.chevron_right),
                  title: Text("Добавить точку"),
                  subtitle: Text("Добавить точку выбранную на карте"),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed('/home/points/add', arguments: '/home/admin');
                  },
                ),
              ),
              Card(
                elevation: 2,
                child: ListTile(
                  trailing: Icon(Icons.chevron_right),
                  title: Text("Список пользователей"),
                  subtitle: Text("Отобразить список всех пользователей"),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed('/home/user/all');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
