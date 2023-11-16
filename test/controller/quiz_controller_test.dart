// ignore_for_file: unused_local_variable

import 'package:adit_quiz/app/models/quiz_model.dart';
import 'package:adit_quiz/app/modules/quiz/quiz_controller.dart';
import 'package:adit_quiz/app/repository/repository_quiz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  /// inject
  Get.lazyPut<QuizRepository>(() => QuizRepository());
  Get.lazyPut<QuizController>(() => QuizController());

  group('QuizController', () {
    late QuizController quizController;
    late QuizRepository quizRepository;

    setUp(() {
      quizController = Get.find<QuizController>();
      quizRepository = Get.find<QuizRepository>();
      quizController.topicSelected.value = 'Music';
    });

    test('onInit test run scenario', () async {
      await quizController.onInit();

      /// 1
      expect(quizController.topicSelected.value, isNotEmpty);

      /// 2
      expect(quizController.questionList, isNotEmpty);

      /// 3
      expect(quizController.currentQuestion.value, isA<QuizModel>());

      /// 4
      expect(quizController.currentTimer.value, isNonNegative);
    });

    // test('onNextQuestion should move to the next question', () async {
    //   quizController.currentUserAnswer.value = Options();
    //   await quizController.onNextQuestion();
    //   expect(quizController.currentQuestionIndex.value, isNot(equals(0)));
    //   expect(quizController.currentUserAnswer.value.title, isNull);
    // });

    // test('onSubmitAnswer should submit the user\'s answer', () async {
    //   quizController.currentUserAnswer.value = Options();
    //   await quizController.onSubmitAnswer();
    //   expect(quizController.reportUserAnswered, isA<List<QuizModel>>());
    // });
  });
}
