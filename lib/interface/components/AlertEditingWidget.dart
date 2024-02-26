import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class AlertEditing {
  static List<String> items = ['Да', 'Нет'];

  static Widget AlertEditingText(BuildContext context, String currentItem) {
    String localItem = currentItem;
    return AlertDialog(
      title: Text("Изменение"),
      content: DropdownSearch<String>(
        popupProps: const PopupProps.menu(
          showSearchBox: false,
        ),
        dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: "",
          ),
        ),
        items: items,
        selectedItem: localItem,
        onChanged: (String? value) {
          localItem = value!;
        },
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              child: Text("Отмена"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Обновить"),
              onPressed: () {
                Navigator.pop(context, localItem);
              },
            ),
          ],
        ),
      ],
    );
  }
}
