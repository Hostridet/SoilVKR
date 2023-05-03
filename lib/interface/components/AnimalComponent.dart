import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimalComponent extends StatefulWidget {
  const AnimalComponent({Key? key}) : super(key: key);

  @override
  State<AnimalComponent> createState() => _AnimalComponentState();
}

class _AnimalComponentState extends State<AnimalComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 2,
          child: ListTile(
            title: Text("Животное"),
            leading: SizedBox(
              width: 100,
              height: 200,
              child: Image.network(
                "https://sun9-49.userapi.com/impg/fxRuNl6Ab9rf8keyQ16xHYKOyxz30V8_sHxkqQ/_C6tWOQnI_Y.jpg?size=1200x800&quality=96&sign=d7bdec4a3ff98a6bc57f4bcd0f69829f&type=album"
              ),
            ),
            subtitle: Text("Описание животного"),
            onTap: () {},
          ),
        )
      ],
    );
  }
}
