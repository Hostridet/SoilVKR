import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import '../../components/Drawer.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  Future<bool> _onWillPop() async {
    Navigator.of(context).pushReplacementNamed('/home');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: DrawerMenu(),
        appBar: AppBar(
          title: const Text('Администрирование'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                  child: Card(
                    elevation: 2,
                    child: ListTile(
                      trailing: Icon(Icons.chevron_right),
                      title: Text("Добавить точку"),
                      subtitle: Text("Добавить точку выбранную на карте"),
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/home/points/add', arguments: '/home/admin');
                      },
                    ),
                  ),
                ),
                Card(
                  elevation: 2,
                  child: ListTile(
                    trailing: Icon(Icons.chevron_right),
                    title: Text("Список пользователей"),
                    subtitle: Text("Отобразить список всех пользователей"),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/home/user/all');
                    },
                  ),
                ),
                Card(
                  elevation: 2,
                  child: ListTile(
                    trailing: Icon(Icons.chevron_right),
                    title: Text("Обновление базы знаний"),
                    subtitle: Text("Добавление новых записей в базу знаний"),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/home/book');
                    },
                  ),
                ),
                Card(
                  elevation: 2,
                  child: ListTile(
                    trailing: Icon(Icons.chevron_right),
                    title: Text("Связь почвы и грунта"),
                    subtitle: Text("Связь между почвой и грунтом"),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/home/admin/soilground');
                    },
                  ),
                ),
                Card(
                  elevation: 2,
                  child: ListTile(
                    trailing: Icon(Icons.chevron_right),
                    title: Text("Связь почвы и растений"),
                    subtitle: Text("Связь между почвой и растениями"),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/home/admin/soilplant');
                    },
                  ),
                ),
                Card(
                  elevation: 2,
                  child: ListTile(
                    trailing: Icon(Icons.chevron_right),
                    title: Text("Связь растений и животных"),
                    subtitle: Text("Связь между растениями и животными"),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/home/admin/plantanimal');
                    },
                  ),
                ),
                Card(
                  elevation: 2,
                  child: ListTile(
                    trailing: Icon(Icons.chevron_right),
                    title: Text("Связь территорий и почв"),
                    subtitle: Text("Связь между территориями и почвами"),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/home/admin/locationsoil');
                    },
                  ),
                ),
                Card(
                  elevation: 2,
                  child: ListTile(
                    trailing: Icon(Icons.chevron_right),
                    title: Text("Связь территорий и климата"),
                    subtitle: Text("Связь между территориями и климатом"),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/home/admin/locationclimat');
                    },
                  ),
                ),
                Card(
                  elevation: 2,
                  child: ListTile(
                    trailing: Icon(Icons.chevron_right),
                    title: Text("Связь территорий и оснований"),
                    subtitle: Text("Связь между территориями и основаниями"),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/home/admin/locationfoundation');
                    },
                  ),
                ),
                Card(
                  elevation: 2,
                  child: ListTile(
                    trailing: Icon(Icons.chevron_right),
                    title: Text("Связь территорий и вод"),
                    subtitle: Text("Связь между территориями и водами"),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/home/admin/locationwater');
                    },
                  ),
                ),
                Card(
                  elevation: 2,
                  child: ListTile(
                    trailing: Icon(Icons.chevron_right),
                    title: Text("Связь территорий и рельефом"),
                    subtitle: Text("Связь между территориями и рельефом"),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/home/admin/locationrelief');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
