import 'package:get/get.dart';

class MaleServices {
  String? service;
  String? price;
  String? description;
  String? id;
  String? imageUrl;
  RxBool isFav = false.obs; // 🔁 Reactive variable

  MaleServices({
    this.service,
    this.price,
    this.description,
    this.id,
    this.imageUrl,
    bool? isFav, // take initial bool
  }) {
    this.isFav.value = isFav ?? false;
  }

  MaleServices.fromJson(Map<String, dynamic> json) {
    service = json['service'];
    price = json['price'];
    description = json['description'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    isFav.value = json['isFav'] ?? false;
  }

  Map<String, dynamic> toJson() {
    return {
      'service': service,
      'price': price,
      'description': description,
      'id': id,
      'imageUrl': imageUrl,
      'isFav': isFav.value, // 🔄 Convert RxBool to plain bool
    };
  }
}
