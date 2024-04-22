class Owner {
  late String name;
  late String face;
  late int fans;

  Owner.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    face = json['face'];
    fans = json['fans'];
  }

  //将mo转成map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['face'] = face;
    data['fans'] = fans;
    return data;
  }
}
