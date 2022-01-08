class PhoneModel {
  List<PhoneItem> phones;

  PhoneModel({
    required this.phones,
  });

  factory PhoneModel.fromJSON(List json) {
    return PhoneModel(
      phones: json == null
          ? []
          : json.map((e) => PhoneItem.fromJSON(e)).toList(),
    );
  }
}

class PhoneItem {
  final String name;
  final List<PhoneItem> children;
  bool isExpanded = false;

  PhoneItem({
    required this.name,
    required this.children,
  });

  factory PhoneItem.fromJSON(Map<String, dynamic> json) {
    return PhoneItem(
        name: json['Name'],
        children: json['Children'] == null
      ? []
      : (json['Children'] as List).map((e) => PhoneItem.fromJSON(e)).toList(),
    );
  }
}