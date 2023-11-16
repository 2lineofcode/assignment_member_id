import 'dart:math';

import 'package:get/get.dart';

import '../../core/app_firebase.dart';
import '../../models/topics_model.dart';
import '../../repository/repository_topic.dart';
import '../../routes/app_pages.dart';

class HomeController extends GetxController with StateMixin {
  final repoTopic = Get.find<TopicRepository>(); // inject repo
  final topicList = <TopicModel>[].obs;

  @override
  Future<void> onInit() async {
    await logEvent('Open Home Screen');

    topicList.value = await repoTopic.getTopicList();
    change(200, status: RxStatus.success());
    super.onInit();
  }

  Future<void> onPlay() async {
    await logEvent('User Click onPlay');

    /// random pick topic
    topicList.shuffle();
    final topic = topicList[Random().nextInt(topicList.length)];
    await Get.toNamed(Routes.QUIZ, arguments: topic.name);
  }

  Future<void> goTopic() async {
    await logEvent('User Click goTopic');
    await Get.toNamed(Routes.TOPICS);
  }
}
