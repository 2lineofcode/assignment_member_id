class QuizModel {
  int? number;
  int? timer;
  String? topic;
  String? question;
  String? media;
  List<Options>? options;
  Options? userAnswer;

  QuizModel({
    this.number,
    this.timer,
    this.topic,
    this.question,
    this.media,
    this.options,
    this.userAnswer,
  });

  QuizModel.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    timer = json['timer'];
    topic = json['topic'];
    question = json['question'];
    media = json['media'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
    userAnswer = json['user_answer'] != null ? Options.fromJson(json['user_answer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['timer'] = timer;
    data['topic'] = topic;
    data['question'] = question;
    data['media'] = media;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    if (userAnswer != null) {
      data['user_answer'] = userAnswer!.toJson();
    }
    return data;
  }
}

class Options {
  String? title;
  bool? isCorrect;

  Options({this.title, this.isCorrect});

  Options.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    isCorrect = json['is_correct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['is_correct'] = isCorrect;
    return data;
  }
}
