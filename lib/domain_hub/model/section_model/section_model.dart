class SectionsModel {
  String? sectionType;
  String? viewType;
  String? title;
  String? sectionId;
  dynamic items;

  SectionsModel({
    this.sectionType,
    this.viewType,
    this.title,
    this.sectionId,
    this.items,
  });

  SectionsModel.fromJson(Map<String, dynamic> json) {
    sectionType = json['sectionType'];
    viewType = json['viewType'];
    title = json['title'];
    sectionId = json['sectionId'];
    if (json['items'] != null) {
      if (json['sectionType'] == 'new-release') {
        items = json['items'];
      } else {
        items = [];
        json['items'].forEach((v) {
          items!.add(v);
        });
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sectionType'] = sectionType;
    data['viewType'] = viewType;
    data['title'] = title;
    data['sectionId'] = sectionId;
    if (items != null) {
      data['items'] = items!;
    }
    return data;
  }
}
