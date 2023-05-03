import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlantComponent extends StatefulWidget {
  const PlantComponent({Key? key}) : super(key: key);

  @override
  State<PlantComponent> createState() => _PlantComponentState();
}

class _PlantComponentState extends State<PlantComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 2,
          child: ListTile(
            title: Text("Растение"),
            leading: SizedBox(
              width: 100,
              height: 200,
              child: Image.network(
                "https://sun9-75.userapi.com/impg/-Rwg1bd_0pbFKUkFOk-FhJR_FAyGGPUoxAIopg/XtH8QzYePPM.jpg?size=1536x1024&quality=96&sign=c1761ee6d0773e359093547c4c10a787&type=album"
              ),
            ),
            subtitle: Text("Описание растения"),
            onTap: () {},

          ),
        )
      ],
    );
  }
}
