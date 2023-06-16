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

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  CarouselController buttonCarouselController = CarouselController();
  late PageController _controller;
  int currentPage = 0;
  List<Images> itemList = [
    Images(text: "Выбрать локацию и посмотреть почвы, растущие растения и проживающих животных", image: "assets/1.jpg", url: "/home/map"),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed("/login");
                    },
                    icon: Icon(Icons.close, color: Colors.grey, size: 40,),
                ),
              ),
            ),
            SizedBox(height: 40,),
            Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text("Основной функционал", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: Colors.black54),),
              ),
            ),
            CarouselSlider.builder(
                carouselController: buttonCarouselController,
                itemCount: itemList.length,
                itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex){
                  return carouselCard(itemList[itemIndex]);
                },
                options: CarouselOptions(
                  height: 400,
                  aspectRatio: 16/9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  reverse: false,
                  autoPlay: false,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentPage = index;
                    });
                  }
                )
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: itemList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => buttonCarouselController.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                            .withOpacity(currentPage == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
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
      ],
    );
  }
}
