class GenresModel {
  String? id;
  String? name;
  String? title;
  String? alias;
  GenresModel? parent;
  List<GenresModel?>? child;

  GenresModel({
    this.id,
    this.name,
    this.title,
    this.alias,
    this.parent,
    this.child,
  });

  GenresModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    alias = json['alias'];
    parent =
        json['parent'] == null ? null : GenresModel.fromJson(json['parent']);
    if (json['child'] != null) {
      child = <GenresModel>[];
      json['child'].forEach((v) {
        child!.add(GenresModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['title'] = title;
    data['alias'] = alias;
    if (child != null) {
      data['child'] = child!.map((v) => v?.toJson()).toList();
    }
    if (parent != null) {
      data['parent'] = parent!.toJson();
    }
    return data;
  }
}
