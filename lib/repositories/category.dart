import 'dart:convert';

import 'package:http/retry.dart';
import 'package:http/http.dart' as http;
import 'package:vetgh/models/category.dart';

class CategoryRepository {
  String url = 'https://api.vetgh.com';
  final client = RetryClient(http.Client());

  Future<List<Category>> getCategories(String entityDivCode) async {
    var headers = {"Content-Type": "application/json;charset=UTF-8"};

    try {
      dynamic res = await http.get(
          Uri.parse('$url/get_categories?entity_div_code=$entityDivCode'),
          headers: headers);

      dynamic res_body = jsonDecode(res.body);

      if (res_body['resp_code'] == '000') {
        return (res_body['details'] as List)
            .map((temp) => Category.fromJson(temp))
            .toList();
      } else {
        throw res_body['resp_desc'];
      }
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
  }
}
