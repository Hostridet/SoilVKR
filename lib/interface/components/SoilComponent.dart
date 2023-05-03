
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SoilComponent extends StatefulWidget {
  const SoilComponent({Key? key}) : super(key: key);

  @override
  State<SoilComponent> createState() => _SoilComponentState();
}

class _SoilComponentState extends State<SoilComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 2,
          child: ListTile(
            title: Text("Почва"),
            leading: SizedBox(
              width: 100,
              height: 200,
              child: Image.network(
                "https://sun9-23.userapi.com/impg/toeWsohS4fktyx0iEumJq0OI-RrRVG-SwvSU_A/r4MXIokb4_Q.jpg?size=820x513&quality=96&sign=92b9e88c7cf42a57f56942b6cce2a83f&type=album"
              ),
            ),
            subtitle: Text("Описание почвы"),
            onTap: () {},

          ),
        )
      ],
    );
  }
}
