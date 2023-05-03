import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soil/interface/components/Drawer.dart';

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
        gradient: const LinearGradient(colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
      ),
      body: SingleChildScrollView(
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
                  title: Text("Румянцев Никита Олегович"),
                  subtitle: Text("ФИО"),
                  leading: Icon(Icons.person, size: 35,color: Colors.orange,),
                  onTap: () {},
                ),
              ),
              Card(
                elevation: 2,
                child: ListTile(
                  title: Text("22 года"),
                  subtitle: Text("Возраст"),
                  leading: Icon(Icons.refresh, size: 35,color: Colors.brown,),
                  onTap: () {},
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("89242422754"),
                  subtitle: Text("Номер"),
                  leading: Icon(Icons.phone, size: 35,color: Colors.green,),
                  onTap: () {},
                ),
              ),
              Card(
                elevation: 2,
                child: ListTile(
                  title: Text("rumyancev-2005@mail.ru"),
                  subtitle: Text("Электронная почта"),
                  leading: Icon(Icons.mail, size: 35,color: Colors.blue,),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
