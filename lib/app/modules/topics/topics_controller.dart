import 'package:get/get.dart';

import '../../core/app_firebase.dart';
import '../../models/topics_model.dart';
import '../../repository/repository_topic.dart';
import '../../routes/app_pages.dart';

class TopicsController extends GetxController with StateMixin {
  final repo = Get.find<TopicRepository>(); // inject repo
  final topicList = <TopicModel>[].obs;

  @override
  Future<void> onInit() async {
    await logEvent('Open Topics Screen');

    topicList.value = await repo.getTopicList();
    change(200, status: RxStatus.success());
    super.onInit();
  }

  Future<void> startQuiz(String topicName) async {
    await logEvent('User Click startQuiz($topicName)');
    await Get.toNamed(Routes.QUIZ, arguments: topicName);
  }
}
