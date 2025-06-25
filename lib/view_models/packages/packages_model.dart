class Packages {
  int? count;
  Null next;
  Null previous;
  List<PackageData>? packagesData;

  Packages({this.count, this.next, this.previous, this.packagesData});

  Packages.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['data'] != null) {
      packagesData = <PackageData>[];
      json['data'].forEach((v) {
        packagesData!.add(PackageData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (packagesData != null) {
      data['data'] = packagesData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PackageData {
  int? id;
  CategoryData? categoryData;
  List<ServiceData>? serviceData;
  String? name;
  dynamic rating; // ✅ if you're not using it, keep it dynamic or Null
  double? discount; // ✅ FIXED
  double? price; // ✅ FIXED
  double? duration; // ✅ FIXED
  String? description;

  PackageData({
    this.id,
    this.categoryData,
    this.serviceData,
    this.name,
    this.rating,
    this.discount,
    this.price,
    this.duration,
    this.description,
  });

  PackageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryData =
        json['category_data'] != null
            ? CategoryData.fromJson(json['category_data'])
            : null;

    if (json['service_data'] != null) {
      serviceData = <ServiceData>[];
      json['service_data'].forEach((v) {
        serviceData!.add(ServiceData.fromJson(v));
      });
    }

    name = json['name'];
    rating = json['rating'];
    discount = json['discount']?.toDouble(); // ✅ Ensures type safety
    price = json['price']?.toDouble();
    duration = json['duration']?.toDouble();
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    if (categoryData != null) {
      data['category_data'] = categoryData!.toJson();
    }
    if (serviceData != null) {
      data['service_data'] = serviceData!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    data['rating'] = rating;
    data['discount'] = discount;
    data['price'] = price;
    data['duration'] = duration;
    data['description'] = description;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}

class ServiceData {
  int? id;
  String? serviceName;
  String? image;

  ServiceData({this.id, this.serviceName, this.image});

  ServiceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['service_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['service_name'] = serviceName;
    data['image'] = image;
    return data;
  }
}
