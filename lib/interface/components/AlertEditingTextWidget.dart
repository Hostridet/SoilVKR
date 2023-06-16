
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertEditingTextWidget {
  static Widget AlertEditingText(BuildContext context, int maxLines, TextEditingController controller) {
    return AlertDialog(
      title: Text("Изменение"),
      content: TextFormField(
        maxLines: maxLines,
        //initialValue: value,
        controller: controller,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              child: Text("Отмена"),
              onPressed:  () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Обновить"),
              onPressed:  () {
                Navigator.pop(context, controller.text);
              },
            ),
          ],
        ),
      ],
    );
  }
}
