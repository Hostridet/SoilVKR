import 'dart:async';
import 'dart:math';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:soil/interface/components/Drawer.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:flutter/foundation.dart';
import 'package:soil/interface/components/InfoLayout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/map_bloc/map_bloc.dart';
import '../../repository/MapRepository.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Images {
  String image;
  String text;
  String url;
  Images({required this.text,  required this.image, required this.url});
}
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _controller;
  int currentPage = 0;
  List<Images> itemList = [
    Images(text: "Выбрать локацию и посмотреть почвы, растущие растения и проживающих животных", image: "assets/1.avif", url: "/home/map"),
    Images(text: "Посмотреть все существующие записи о почвах, растениях и животных", image: "assets/2.jpg", url: "/home/book"),
    Images(text: "Изменить цветовую тему приложения", image: "assets/3.png", url: "/home/settings")
  ];
  @override
  void initState() {
    _controller = PageController(initialPage: currentPage, viewportFraction: 0.8);
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: NewGradientAppBar(
        title: const Text('Главный экран'),
        gradient: const LinearGradient(colors: [Color(0xff228B22), Color(0xff008000), Color(0xff006400)]),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.green),
              padding: const EdgeInsets.all(20.0),
              child: Text(
                  "Soil VKR - это прототип программной системы, основанной на знаниях, способной определить местность с указанием распределения почв на ней,"
                  " содержащей сведения о почвах, их свойствах, характерных для них грунтах и кормовых растениях",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
                ),
              ),
            ),
            Divider(),
            Padding(
                padding: EdgeInsets.all(10),
              child: Center(
                child: Text("Основной функционал", style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),),
              ),
            ),
            CarouselSlider.builder(
                itemCount: itemList.length,
                itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex){
                  return carouselCard(itemList[itemIndex]);
                },
                options: CarouselOptions(
                  height: 400,
                  aspectRatio: 16/9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                )
            ),
          ],
        ),
      ),
    );
  }
  Widget carouselView(int index) {
    return carouselCard(itemList[index]);
  }


  Widget carouselCard(Images data) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Hero(
              tag: data.image,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(data.url);
                },
                child: SizedBox(
                  width: 250,
                  height: 250,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 3,
                    child: Image.asset(data.image, fit: BoxFit.contain,),
                  ),
                ),
                // child: Container(
                //   width: 250,
                //   height: 250,
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(30),
                //       image: DecorationImage(
                //           image: AssetImage(
                //             data.image,
                //           ),
                //           fit: BoxFit.fill),
                //       boxShadow: const [
                //         BoxShadow(
                //             offset: Offset(0, 4),
                //             blurRadius: 4,
                //             color: Colors.black26)
                //       ]),
                // ),
              ),
            ),
          ),
        ),
        Container(
          width: 400,
          height: 70,
          child: Text(
            data.text,
            style: const TextStyle(
                color: Colors.black45,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Text(
        //     "\$${data.price}",
        //     style: const TextStyle(
        //         color: Colors.black87,
        //         fontSize: 16,
        //         fontWeight: FontWeight.bold),
        //   ),
        // )
      ],
    );
  }
}
