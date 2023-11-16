import 'package:get/get.dart';

import '../../repository/repository_topic.dart';
import 'topics_controller.dart';

class TopicsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopicRepository>(() => TopicRepository(), fenix: true);
    Get.lazyPut<TopicsController>(() => TopicsController(), fenix: true);
  }
}
