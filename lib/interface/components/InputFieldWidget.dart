import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.focusNode,
    required this.textController,
    required this.label,
    required this.icons,
  }) : super(key: key);

  final FocusNode focusNode;
  final TextEditingController textController;
  final String label;
  final Icon icons;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.00),
      child: TextFormField(
        obscureText: label == "Пароль" ? true : false,
        controller: textController,
        autofocus: false,
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(focusNode);
        },
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color:  Colors.green),
                borderRadius: BorderRadius.circular(5.5)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color:  Colors.green),
                borderRadius: BorderRadius.circular(5.5)),
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.transparent,
            hintText: label,
            prefixIcon: icons),
      ),
    );
  }
}