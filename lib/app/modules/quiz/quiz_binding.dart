import 'package:get/get.dart';

import '../../repository/repository_quiz.dart';
import 'quiz_controller.dart';

class QuizBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuizRepository>(() => QuizRepository(), fenix: true);
    Get.lazyPut<QuizController>(() => QuizController(), fenix: true);
  }
}
