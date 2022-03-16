import 'package:flutter/material.dart';
import 'package:vetgh/models/nominee.dart';
import 'package:vetgh/screens/vote.dart';

class NomineeCard extends StatelessWidget {
  final Nominee nominee;

  const NomineeCard({Key? key, required this.nominee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => Vote(nominee: nominee))),
        title: Text(nominee.nominee!,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Nominee Code: ', style: TextStyle(fontSize: 12)),
                Text(
                  nominee.nomCode!,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const Text(
              'Click to Vote',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        leading: nominee.nomPic != null
            ? Container(
          height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image:
                        DecorationImage(image: NetworkImage(nominee.nomPic!), fit: BoxFit.cover, alignment: Alignment.topCenter)))
            : const Icon(
                Icons.person,
                size: 50,
              ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          size: 14,
        ));
  }
}
