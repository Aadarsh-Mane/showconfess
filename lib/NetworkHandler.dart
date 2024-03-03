import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkHandler {
  var log = Logger();
  String baseUrl = "https://confessbackend-1.onrender.com";

  Future<Map<String, dynamic>> get(String url) async {
    Uri uri = Uri.parse(formatter(url));
    var response = await http.get(uri);
    log.d('GET $url');
    log.d('Response status code: ${response.statusCode}');
    log.d('Response body: ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i('GET request successful');
      return json.decode(response.body);
    } else {
      log.e('GET request failed');
      return {}; // or throw an exception
    }
  }

  Future<http.Response> post(String url, Map<String, String> body) async {
    Uri uri = Uri.parse(formatter(url));
    var response = await http.post(
      uri,
      headers: {"Content-type": "application/json"},
      body: json.encode(body),
    );
    log.d('POST $url with body: $body');
    log.d('Response status code: ${response.statusCode}');
    log.d('Response body: ${response.body}');
    // if (response.statusCode == 200 || response.statusCode == 201) {
    log.i('POST request successful');
    // return response;
    // } else {
    // log.e('POST request failed');
    // return null; // or throw an exception
    return response;
  }

  String formatter(String url) {
    return baseUrl + url;
  }
}
