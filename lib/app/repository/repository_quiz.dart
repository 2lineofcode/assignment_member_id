import 'dart:developer' as dev;
import '../core/app_firebase.dart';
import '../models/quiz_model.dart';

class QuizRepository {
  /// GET ALL
  Future<List<QuizModel>> getQuizList(String topicName) async {
    final query = await db
        .collection(quizBank)
        .where('topic', isEqualTo: topicName)
        .withConverter<QuizModel>(
          fromFirestore: (snapshot, options) => QuizModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .get();
    return query.docs.map((doc) => doc.data()).toList();
  }

  /// ADD
  Future<void> addQuiz(QuizModel quizModel) async {
    await db.collection(quizBank).add(quizModel.toJson()).then((value) {
      dev.log('message: success');
    }).catchError((error) {
      dev.log('message: $error');
      crash.log(error);
    });
  }

  /// DELETE
  Future<void> deleteQuiz(String id) async {
    await db.collection(quizBank).doc(id).delete().then((value) {
      dev.log('message: success');
    }).catchError((error) {
      dev.log('message: $error');
      crash.log(error);
    });
  }
}
