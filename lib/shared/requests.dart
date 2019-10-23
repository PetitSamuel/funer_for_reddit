import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:funer_for_reddit/secret/secret.dart';

final String basicAuth =
    "Basic " + base64Encode(utf8.encode('$CLIENT_ID:$PASSWORD'));
final Map<String, String> defaultHeaders = {
  "Authorization": basicAuth,
  'Content-Type': 'application/x-www-form-urlencoded'
};
const String oauthUrlBase = "https://www.reddit.com/api/v1";
const String urlBase = "https://www.oauth.reddit.com/api/v1";

String urlBuilder(String endpoint, {bool auth = false}) {
  String realEndpoint = endpoint;
  if (!endpoint.startsWith("/")) realEndpoint = "/" + endpoint;
  return (auth ? urlBase : oauthUrlBase) + realEndpoint;
}

Future<http.Response> buildRequestAndPost(String url,
    {bool useDefaultHeaders = true,
    Map<String, String> headers,
    dynamic body}) async {
  return await httpPost(
      url, useDefaultHeaders ? defaultHeaders : headers, body);
}

Future<http.Response> httpPost(
    String url, Map<String, String> headers, dynamic body) async {
  return await http.post(url, headers: headers, body: body);
}

Future<http.Response> buildRequestAndGet(String url,
    {bool useDefaultHeaders = true,
    Map<String, String> headers,
    dynamic body}) async {
  return await httpGet(url, useDefaultHeaders ? defaultHeaders : headers);
}

Future<http.Response> httpGet(String url, Map<String, String> headers) async {
  return await http.get(url, headers: headers);
}
