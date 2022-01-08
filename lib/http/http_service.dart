import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smeet_task/phone/model/phone_model.dart';

class HttpService {
  static const String _baseUrl = "harshveersingh.github.io";
  static const String _getPhones = "/ia/phones.json";

  static Future<dynamic> getPhones() async {
    try {
      Uri uri = Uri.https(_baseUrl, _getPhones);
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        PhoneModel res = PhoneModel.fromJSON(json.decode(response.body));
        return res;
      }
    }
    catch (_) {}
    return null;
  }
}