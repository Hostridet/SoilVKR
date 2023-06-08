import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class DisplayImage extends StatelessWidget {
  String? image;
  String? loadingImage;

  // Constructor
  DisplayImage({
    Key? key,
    this.image,
    this.loadingImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Colors.green;

    return Center(
        child: Stack(children: [
          buildImage(color),
          Positioned(
            child: buildEditIcon(color),
            right: 4,
            top: 10,
          )
        ]));
  }

  // Builds Profile Image
  Widget buildImage(Color color) {

    return CircleAvatar(
      radius: 75,
      backgroundColor: color,
      child: image != null
          ? CircleAvatar(
        backgroundColor: Colors.grey,
        backgroundImage: MemoryImage(base64Decode(image!)),
        radius: 70,
      )
          : CircleAvatar(
        backgroundColor: Colors.grey,
        backgroundImage: AssetImage(loadingImage!),
        radius: 70,
      ),
    );
  }

  // Builds Edit Icon on Profile Picture
  Widget buildEditIcon(Color color) => buildCircle(
      all: 8,
      child: Icon(
        Icons.edit,
        color: color,
        size: 20,
      ));

  // Builds/Makes Circle for Edit Icon on Profile Picture
  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      ClipOval(
          child: Container(
            padding: EdgeInsets.all(all),
            color: Colors.white,
            child: child,
          ));
}