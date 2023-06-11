
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/journal.dart';
import '../../util/app_color.dart';
import '../../util/app_text_style.dart';
import '../page/schedule_journal/journal/journal_detail_page.dart';

class JournalTile extends StatelessWidget {
  const JournalTile({Key? key, required this.journal}) : super(key: key);
  final Journal journal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          Get.to(() => JournalDetailPage(journal: journal));
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            height: 90,
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      child: CircleAvatar(
                        backgroundColor: AppColor.black20,
                        backgroundImage: journal.plant.imageUrl != null ? NetworkImage(journal.plant.imageUrl!) : null,
                        child: journal.plant.imageUrl != null ? null : Icon(Icons.person, color: AppColor.white),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      constraints: BoxConstraints(maxWidth: 50),
                      child: Text('${journal.plant.name}', style: AppTextStyle.body4_m(), overflow: TextOverflow.ellipsis)
                    ),
                    SizedBox(height: 2),
                    Container(
                      constraints: BoxConstraints(maxWidth: 50),
                      child: Text('${journal.plant.species}', style: AppTextStyle.body5_r(color: AppColor.black40))
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            width: 180,
                            child: Text('${journal.content}', style: AppTextStyle.body4_r(), maxLines: 3, overflow: TextOverflow.ellipsis)
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 90,
                          height: 90,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            image: journal.imageUrl != null ? DecorationImage(image: NetworkImage(journal.imageUrl!), fit: BoxFit.cover) : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
