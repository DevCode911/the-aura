import 'package:get/get.dart';
import 'package:the_aura/view_models/packages/packages_controller.dart';

class CounterButtonController extends GetxController {
  final Map<String, RxInt> _counters = {};

  var selectedServiceIds = <String>{}.obs;

  var totalPrice = 0.0.obs;

  final packagesController = Get.find<PackagesController>();

  RxInt getCounter(String id) {
    return _counters.putIfAbsent(id, () => 0.obs);
  }

  void increment(String id) {
    final counter = getCounter(id);
    counter.value++;
    selectedServiceIds.add(id);
    _updateTotalPrice();
  }

  void decrement(String id) {
    final counter = getCounter(id);
    if (counter.value > 0) {
      counter.value--;
      if (counter.value == 0) {
        selectedServiceIds.remove(id);
      }
    }
    _updateTotalPrice();
  }

  void _updateTotalPrice() {
    double total = 0.0;
    for (var id in selectedServiceIds) {
      final package = packagesController.packagesList.firstWhereOrNull(
        (s) => s.id?.toString() == id,
      );
      if (package != null) {
        final price = package.price ?? 0.0;
        final quantity = getCounter(id).value;
        total += price * quantity;
      }
    }
    totalPrice.value = total;
  }
}
