class CategoryResponse {
  int? count;
  dynamic next;
  dynamic previous;
  List<Category>? data;

  CategoryResponse({this.count, this.next, this.previous, this.data});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      data: (json['data'] as List).map((e) => Category.fromJson(e)).toList(),
    );
  }
}

class Category {
  int? id;
  String? name;
  String? image; // Change Null to String?

  Category({this.id, this.name, this.image});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'], name: json['name'], image: json['image']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'image': image};
  }
}
