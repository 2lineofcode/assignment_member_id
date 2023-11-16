class TopicModel {
  String? name;
  String? description;
  String? img;

  TopicModel({this.name, this.description, this.img});

  TopicModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['img'] = img;
    return data;
  }
}
