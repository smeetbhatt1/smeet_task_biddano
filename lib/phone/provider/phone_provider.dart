import 'package:flutter/foundation.dart';
import 'package:smeet_task/http/http_service.dart';
import 'package:smeet_task/phone/model/phone_model.dart';

class PhoneProvider with ChangeNotifier {
  bool showLoader = true;
  List<PhoneItem> phones = [];

  Future<void> getPhones() async {
    showLoader = true;
    notifyListeners();

    try {
      final res = await HttpService.getPhones();
      if (res != null && res is PhoneModel) {
        phones = res.phones;
      }
      else {
        //show error.
      }
    }
    catch (_) {}

    showLoader = false;
    notifyListeners();
  }

  void setIsExpanded(PhoneItem item, bool value) {
    item.isExpanded = value;
    notifyListeners();
  }

  void addItem(PhoneItem item) {
    item.children.add(PhoneItem(
      name: "New Item Added ${item.children.length}",
      children: [],
    ),
    );
    notifyListeners();
  }
}
