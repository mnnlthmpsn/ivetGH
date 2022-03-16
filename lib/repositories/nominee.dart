import 'dart:convert';

import 'package:http/retry.dart';
import 'package:http/http.dart' as http;
import 'package:vetgh/models/nominee.dart';

class NomineeRepository {
  String url = 'https://api.vetgh.com';
  final client = RetryClient(http.Client());

  Future<List<Nominee>> getNominees(String catID) async {
    var headers = {"Content-Type": "application/json;charset=UTF-8"};

    try {
      dynamic res = await http.get(Uri.parse('$url/get_nominees?cat_id=$catID'),
          headers: headers);

      dynamic res_body = jsonDecode(res.body);
      if (res_body['resp_code'] == '000') {
        return (res_body['details'] as List)
            .map((temp) => Nominee.fromJson(temp))
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

  Future getPaymentDetails(String nomCode) async {
    var headers = {"Content-Type": "application/json;charset=UTF-8"};

    try {
      dynamic res = await http.get(
          Uri.parse('$url/get_event_payment_details?nom_code=$nomCode'),
          headers: headers);

      var res_body = jsonDecode(res.body);
      if (res_body['resp_code'] == '000') {
        return res_body;
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
