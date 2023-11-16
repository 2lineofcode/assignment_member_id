import 'package:flutter/cupertino.dart';
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
      appBar: AppBar(
        title: Text('Topics'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.search),
            onPressed: () {
              showSearch(context: context, delegate: MySearchDelegate());
            },
          )
        ],
      ),
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

/// search delegate
class MySearchDelegate extends SearchDelegate {
  final controller = Get.find<TopicsController>();
  final suggest = <String>[].obs;

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(CupertinoIcons.back),
      onPressed: () => close(context, null),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(CupertinoIcons.clear),
        onPressed: () => close(context, null),
      ),
    ];
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    suggest.value = controller.topicList.map((e) => e.name ?? '').toList();
    final matchQuery = [];
    for (var item in suggest) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        final item = matchQuery[index];
        return ListTile(
          title: Text(item),
          onTap: () {
            query = item;
            close(context, item);
            controller.startQuiz(item);
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    suggest.value = controller.topicList.map((e) => e.name ?? '').toList();
    final matchQuery = [];
    for (var item in suggest) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        final item = matchQuery[index];
        return ListTile(
          title: Text(item),
          onTap: () {
            query = item;
            close(context, item);
            controller.startQuiz(item);
          },
        );
      },
    );
  }
}
