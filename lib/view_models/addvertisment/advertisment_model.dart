class Addvertisment {
  String? status;
  List<Adds>? add;

  Addvertisment({this.status, this.add});

  Addvertisment.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      add = <Adds>[];
      json['data'].forEach((v) {
        add!.add(Adds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> add = <String, dynamic>{};
    add['status'] = status;
    if (this.add != null) {
      add['data'] = this.add!.map((v) => v.toJson()).toList();
    }
    return add;
  }
}

class Adds {
  int? id;
  String? image;

  Adds({this.id, this.image});

  Adds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> add = <String, dynamic>{};
    add['id'] = id;
    add['image'] = image;
    return add;
  }
}
