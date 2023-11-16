import 'dart:async';
import 'dart:developer' as dev;
import 'package:get/get.dart';

import '../../core/app_firebase.dart';
import '../../models/quiz_model.dart';
import '../../repository/repository_quiz.dart';
import '../../routes/app_pages.dart';

class QuizController extends GetxController with StateMixin {
  final repo = Get.find<QuizRepository>(); // inject repo

  final topicSelected = ''.obs;
  final questionList = <QuizModel>[].obs;

  final currentQuestionIndex = 0.obs;
  final currentQuestion = QuizModel().obs;
  final currentTimer = 0.obs;
  final currentUserAnswer = Options().obs;

  final reportUserAnswered = <QuizModel>[].obs;

  late Timer? _timer;

  @override
  Future<void> onInit() async {
    try {
      await logEvent('Open Quiz Screen');
      topicSelected.value = Get.arguments ?? '';

      await logEvent('Load Quiz with Topic ${topicSelected.value}');
      questionList.value = await repo.getQuizList(topicSelected.value);
      questionList.shuffle();

      currentQuestion.value = questionList.first;
      await onSetupTimerPerQuestion();

      change(200, status: RxStatus.success());
    } catch (e) {
      change(200, status: RxStatus.error());
    }

    super.onInit();
  }

  @override
  void onClose() {
    if (_timer != null) {
      _timer?.cancel();
    }
    logEvent('User Close Quiz Screen');
    super.onClose();
  }

  /// flow:
  /// waktu timer diambil dari firestore.question.timer
  /// case 1: kalo waktu habis dan bukan soal terakhir -> force next question
  /// case 2: kalo waktu habis dan soal terakhir -> force kumpulkan
  Future<void> onSetupTimerPerQuestion() async {
    currentTimer.value = currentQuestion.value.timer ?? 0;
    _timer = Timer.periodic(1.seconds, (_) async {
      currentTimer.value--;
      if (currentTimer.value == 0) {
        /// case 1: waktu habis dan bukan soal terakhir -> force next question
        if (currentQuestionIndex.value < questionList.length - 1) {
          await onNextQuestion(isTimeout: true);
          dev.log('timeout kak, next question!!');
          _timer?.cancel();
        }

        /// case 2: waktu habis dan soal terakhir -> force kumpulkan
        else {
          await onSubmitAnswer();
          dev.log('timeout kak, kumpulkan!!');
          _timer?.cancel();
        }
      }
    });
  }

  Future<void> onNextQuestion({bool isTimeout = false}) async {
    /// check is user already answered
    if (currentUserAnswer.value.title == null && !isTimeout) {
      Get.snackbar('Yoo', 'Masih ada waktu untuk jawab, tolong pilih salah satu options dulu~');
      return;
    }

    /// add to reportUserAnswered (tampung di list terkait soal & user answer)
    reportUserAnswered.add(currentQuestion.value..userAnswer = currentUserAnswer.value);

    /// next question
    if (!isTimeout) _timer?.cancel();
    currentQuestion.value = questionList[currentQuestionIndex.value + 1];
    currentQuestionIndex.value++;

    /// reset user answer
    currentUserAnswer.value = Options();

    /// re-setup timer for next question
    await onSetupTimerPerQuestion();

    /// update ui
    await Get.forceAppUpdate();
  }

  Future<void> onSubmitAnswer() async {
    _timer?.cancel();
    reportUserAnswered.add(currentQuestion.value..userAnswer = currentUserAnswer.value);
    await Get.offNamed(Routes.REPORT_SCORE, arguments: reportUserAnswered);
    await logEvent('User Submit Answer');
  }

  Future<void> exitQuiz() async {
    await Get.defaultDialog(
      title: 'Are u sure?',
      middleText: 'Do you want to exit the quiz?',
      textConfirm: 'Yes',
      textCancel: 'No',
      onConfirm: () async {
        Get.close(2);
        await logEvent('User Exit Quiz');
      },
    );
  }
}
