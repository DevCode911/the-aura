class SubCategory {
  int? count;
  Null next;
  Null previous;
  List<Data>? data;

  SubCategory({this.count, this.next, this.previous, this.data});

  SubCategory.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  CategoryData? categoryData;
  String? name;
  String? image;

  Data({this.id, this.categoryData, this.name, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryData =
        json['category_data'] != null
            ? new CategoryData.fromJson(json['category_data'])
            : null;
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.categoryData != null) {
      data['category_data'] = this.categoryData!.toJson();
    }
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class CategoryData {
  int? id;
  String? name;
  String? image;

  CategoryData({this.id, this.name, this.image});

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
