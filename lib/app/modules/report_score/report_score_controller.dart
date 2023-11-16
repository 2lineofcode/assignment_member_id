import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../models/quiz_model.dart';

class ReportScoreController extends GetxController {
  final reportUserAnswered = <QuizModel>[].obs;
  final countCorrectAnswer = 0.obs;

  @override
  void onInit() {
    reportUserAnswered.value = Get.arguments ?? [];

    /// countCorrectAnswer
    reportUserAnswered.forEach((element) {
      if (element.userAnswer?.isCorrect == true) {
        countCorrectAnswer.value++;
      }
    });
    super.onInit();
  }

  Future<void> share() async {
    await Share.share(
      'Hei, I got score ${countCorrectAnswer.value / reportUserAnswered.length * 100} with this app!',
      subject: 'Score Quiz App',
    );
  }
}
