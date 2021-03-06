import 'dart:convert';
import 'dart:io';

import 'package:http/retry.dart';
import 'package:vetgh/helpers.dart';
import 'package:vetgh/models/event.dart';
import 'package:http/http.dart' as http;

class EventRepository {
  String url = 'https://api.vetgh.com';

  Future<List<Event>> getEvents() async {
    try {
      var headers = {"Content-Type": "application/json;charset=UTF-8"};

      dynamic res =
          await http.get(Uri.parse('$url/get_awards'), headers: headers);

      List<Event> events = (jsonDecode(res.body) as List)
          .map((temp) => Event.fromJson(temp))
          .toList();

      return events;
    }
    catch (e) {
      rethrow;
    }
  }

  Future vote(params) async {
    var headers = {"Content-Type": "application/json;charset=UTF-8"};

    var encode = json.encode(params);

    dynamic res = await http.post(Uri.parse('$url/req_process_payment'),
        headers: headers, body: encode);

    var response = jsonDecode(res.body);
    return response;
  }

  Future sendMessage(message) async {
    var headers = {"Content-Type": "application/json;charset=UTF-8"};

    var encode = json.encode(message);

    dynamic res = await http.post(Uri.parse('$url/req_contact_us'),
        headers: headers, body: encode);

    var response = jsonDecode(res.body);
    print(response);
    return response;
  }
}
