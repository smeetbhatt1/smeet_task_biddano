import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smeet_task/phone/model/phone_model.dart';
import 'package:smeet_task/phone/provider/phone_provider.dart';

class MyExpansion extends StatelessWidget {
  final PhoneItem item;
  const MyExpansion({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: GestureDetector(
        onTap: () {
          Provider.of<PhoneProvider>(context, listen: false)
              .addItem(item);
        },
        child: Text(item.name),
      ),
      children: item.children.map((e) => MyExpansion(item: e,)).toList(),
      onExpansionChanged: (bool expanded) {
        Provider.of<PhoneProvider>(context, listen: false)
            .setIsExpanded(item, expanded);
      },
    );
  }
}
