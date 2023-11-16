import 'dart:developer' as dev;
import '../core/app_firebase.dart';
import '../models/topics_model.dart';

class TopicRepository {
  /// GET ALL
  Future<List<TopicModel>> getTopicList({String? search = ''}) async {
    final query = await db
        .collection(topics)
        .orderBy('name')
        .startAt([search])
        .endAt(['$search\uf8ff'])
        .withConverter<TopicModel>(
          fromFirestore: (snapshot, options) => TopicModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .get();
    return query.docs.map((doc) => doc.data()).toList();
  }

  /// ADD
  Future<void> addTopic(String name, String description) async {
    final newTopic = TopicModel(name: name, img: '', description: description);
    await db.collection(topics).add(newTopic.toJson()).then((value) {
      dev.log('message: success');
    }).catchError((error) {
      dev.log('message: $error');
    });
  }

  /// UPDATE
  Future<void> updateTopic(String id, String name, String description) async {
    await db.collection(topics).doc(id).update({
      'name': name,
      'description': description,
    }).then((value) {
      dev.log('message: success');
    }).catchError((error) {
      dev.log('message: $error');
      crash.log(error);
    });
  }

  /// DELETE
  Future<void> deleteTopic(String id) async {
    await db.collection(topics).doc(id).delete().then((value) {
      dev.log('message: success');
    }).catchError((error) {
      dev.log('message: $error');
      crash.log(error);
    });
  }
}
