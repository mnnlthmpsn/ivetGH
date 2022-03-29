import 'package:flutter/material.dart';
import 'package:vetgh/models/category.dart';
import 'package:vetgh/models/event.dart';
import 'package:vetgh/screens/nominees.dart';

class CategoryCard extends StatelessWidget {

  final Category category;
  final Event event;

  const CategoryCard({Key? key, required this.event, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Nominees(category: category, event: event,)));
        },
        title: Text(category.category!,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        subtitle: Text(
          category.categoryDesc!.isNotEmpty ? category.categoryDesc! : 'No description for Category',
          style: const TextStyle(fontSize: 12),
        ),
        leading: const Icon(
          Icons.image,
          size: 40,
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          size: 14,
        ));
  }
}
