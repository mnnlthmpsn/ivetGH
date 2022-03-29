import 'package:flutter/material.dart';
import 'package:vetgh/helpers.dart';
import 'package:vetgh/models/event.dart';
import 'package:vetgh/screens/categories.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Categories(event: event)));
          },
          title: Text(event.award!,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          subtitle: Text(
            event.entityName != null ? event.entityName! : 'VetGH',
            style: TextStyle(fontSize: 12),
          ),
          leading: event.logo != null
              ? Container(
            width: 50, height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                image:NetworkImage(event.logo)
              )
            ),
          )
              : const Icon(
                  Icons.image,
                  size: 40,
                ),
          trailing: const Icon(
            Icons.chevron_right_rounded,
            size: 14,
          ));
    });
  }
}
