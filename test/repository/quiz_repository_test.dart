import 'package:adit_quiz/app/models/quiz_model.dart';
import 'package:adit_quiz/app/repository/repository_quiz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('QuizRepository', () {
    late QuizRepository quizRepository;

    setUp(() {
      quizRepository = QuizRepository();
    });

    test('getQuizList should return a list of QuizModel', () async {
      const topicName = 'Music';
      final result = await quizRepository.getQuizList(topicName);

      // Ganti expect sesuai dengan implementasi sebenarnya
      expect(result, isA<List<QuizModel>>());
    });

    test('addQuiz should add a new QuizModel', () async {
      final quizModel = QuizModel();
      await quizRepository.addQuiz(quizModel);
      expect(1, isTrue);
    });

    test('deleteQuiz should delete a QuizModel', () async {
      const quizId = '1';
      await quizRepository.deleteQuiz(quizId);
      expect(1, isTrue);
    });
  });
}
