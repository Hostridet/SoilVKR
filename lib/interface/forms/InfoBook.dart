import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:soil/interface/components/AnimalComponent.dart';
import 'package:soil/interface/components/ClimatComponent.dart';
import 'package:soil/interface/components/FoundationComponent.dart';
import 'package:soil/interface/components/GroundComponent.dart';
import 'package:soil/interface/components/PlantComponent.dart';
import 'package:soil/interface/components/ReliefComponent.dart';
import 'package:soil/interface/components/SoilComponent.dart';
import 'package:soil/interface/components/WaterComponent.dart';

import '../components/Drawer.dart';

class InfoBook extends StatefulWidget {
  const InfoBook({Key? key}) : super(key: key);

  @override
  State<InfoBook> createState() => _InfoBookState();
}

class _InfoBookState extends State<InfoBook> {
  Future<bool> _onWillPop() async {
    Navigator.of(context).pushReplacementNamed('/home');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: DefaultTabController(
        length: 8,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            drawer: DrawerMenu(),
            appBar: AppBar(
              title: const Text('База знаний'),
              bottom: const TabBar(
                isScrollable: true,
                tabs: [
                  Tab(
                    text: "Растения",
                  ),
                  Tab(
                    text: "Животные",
                  ),
                  Tab(
                    text: "Почва",
                  ),
                  Tab(
                    text: "Грунт",
                  ),
                  Tab(
                    text: "Рельеф",
                  ),
                  Tab(
                    text: "Климат",
                  ),
                  Tab(
                    text: "Воды",
                  ),
                  Tab(
                    text: "Фундаменты",
                  ),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                PlantComponent(),
                AnimalComponent(),
                SoilComponent(),
                GroundComponent(),
                ReliefComponent(),
                ClimatComponent(),
                WaterComponent(),
                FoundationComponent(),
              ],
            )),
      ),
    );
  }
}
