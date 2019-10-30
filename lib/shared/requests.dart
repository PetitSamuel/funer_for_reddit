import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:funer_for_reddit/secret/secret.dart';

final String basicAuth =
    "Basic " + base64Encode(utf8.encode('$CLIENT_ID:$PASSWORD'));
final Map<String, String> defaultAuthHeaders = {
  "Authorization": basicAuth,
  'Content-Type': 'application/x-www-form-urlencoded'
};
const String oauthUrlBase = "https://www.reddit.com/api/v1";
const String redditBasicUrl = "https://www.reddit.com/";
const String urlBase = "https://www.oauth.reddit.com";
const String apiV1 = "/api/v1";

String authUrlBuilder(String endpoint) {
  String realEndpoint = endpoint;
  if (!endpoint.startsWith("/")) realEndpoint = "/" + endpoint;
  return oauthUrlBase + realEndpoint;
}

String nonOauthUrlBuilder(String endpoint) {
  String realEndpoint = endpoint;
  if (!endpoint.startsWith("/")) realEndpoint = "/" + endpoint;
  return redditBasicUrl + realEndpoint;
}

String urlBuilder(String endpoint, {bool isApiV1 = false}) {
  String realEndpoint = endpoint;
  if (!endpoint.startsWith("/")) realEndpoint = "/" + endpoint;
  return urlBase + (isApiV1 ? apiV1 : "") + realEndpoint;
}

buildHeadersFromToken(String accessToken) {
  return {
    'Authorization': 'bearer ' + accessToken,
    'User-Agent': USER_AGENT,
  };
}

Future<http.Response> buildRequestAndPost(String url,
    {bool useAuthHeaders = false,
    String accessToken = "",
    Map<String, String> headers,
    dynamic body}) async {
  return await httpPost(
      url,
      useAuthHeaders
          ? defaultAuthHeaders
          : accessToken.isEmpty ? headers : buildHeadersFromToken(accessToken),
      body);
}

Future<http.Response> httpPost(
    String url, Map<String, String> headers, dynamic body) async {
  return await http.post(url, headers: headers, body: body);
}

Future<http.Response> buildRequestAndGet(String url,
    {String accessToken = "", Map<String, String> headers}) async {
  return await httpGet(
      url, accessToken == "" ? headers : buildHeadersFromToken(accessToken));
}

Future<http.Response> httpGet(String url, Map<String, String> headers) async {
  return await http.get(url, headers: headers);
}
