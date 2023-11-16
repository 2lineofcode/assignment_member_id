import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../core/app_themes.dart';
import 'topics_controller.dart';

class TopicsView extends GetView<TopicsController> {
  const TopicsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Topics')),
      body: controller.obx(
        (state) => VStack(
          [
            ListView.builder(
              itemCount: controller.topicList.length,
              itemBuilder: (context, index) {
                final item = controller.topicList[index];
                return ListTile(
                  tileColor: AppColor.cardColor,
                  title: '${item.name}'.text.make(),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  onTap: () => controller.startQuiz(item.name ?? ''),
                ).pOnly(bottom: 8);
              },
            ).expand(),
          ],
        ).p16(),
      ),
    );
  }
}
