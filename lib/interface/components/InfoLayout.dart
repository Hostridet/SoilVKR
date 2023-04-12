
import 'package:flutter/material.dart';

class InfoLayout {
  static ScaffoldFeatureController buildErrorLayout(BuildContext context, String text) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
        ),
      );
}


