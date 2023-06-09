
import 'package:flutter/material.dart';

import '../../model/journal.dart';
import '../../util/app_color.dart';

class JournalTile extends StatelessWidget {
  const JournalTile({Key? key, required this.journal}) : super(key: key);
  final Journal journal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Column(
            children: [
              CircleAvatar(
                backgroundColor: AppColor.black20,
                backgroundImage: journal.plant.imageUrl != null ? NetworkImage(journal.plant.imageUrl!) : null,
                child: journal.plant.imageUrl != null ? null : Icon(Icons.person, color: AppColor.white),
              ),
              Text('${journal.plant.name}'),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(12),
              color: AppColor.black20,
              child: Row(
                children: [
                  Text('${journal.content}'),
                  Spacer(),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppColor.black20,
                      image: journal.imageUrl != null ? DecorationImage(image: NetworkImage(journal.imageUrl!), fit: BoxFit.cover) : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

