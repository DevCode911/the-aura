class ServiceDetails {
  int? count;
  Null next;
  Null previous;
  List<Data>? data;

  ServiceDetails({this.count, this.next, this.previous, this.data});

  ServiceDetails.fromJson(Map<String, dynamic> json) {
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
  SubCategoryData? subCategoryData;
  Null image;
  String? serviceName;
  String? serviceType;
  int? price;
  int? discount;
  String? description;
  String? timeDuration;

  Data(
      {this.id,
      this.categoryData,
      this.subCategoryData,
      this.image,
      this.serviceName,
      this.serviceType,
      this.price,
      this.discount,
      this.description,
      this.timeDuration});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryData = json['category_data'] != null
        ? new CategoryData.fromJson(json['category_data'])
        : null;
    subCategoryData = json['sub_category_data'] != null
        ? new SubCategoryData.fromJson(json['sub_category_data'])
        : null;
    image = json['image'];
    serviceName = json['service_name'];
    serviceType = json['service_type'];
    price = json['price'];
    discount = json['discount'];
    description = json['description'];
    timeDuration = json['time_duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.categoryData != null) {
      data['category_data'] = this.categoryData!.toJson();
    }
    if (this.subCategoryData != null) {
      data['sub_category_data'] = this.subCategoryData!.toJson();
    }
    data['image'] = this.image;
    data['service_name'] = this.serviceName;
    data['service_type'] = this.serviceType;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['description'] = this.description;
    data['time_duration'] = this.timeDuration;
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

class SubCategoryData {
  int? id;
  CategoryData? categoryData;
  String? name;
  Null image;

  SubCategoryData({this.id, this.categoryData, this.name, this.image});

  SubCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryData = json['category_data'] != null
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
