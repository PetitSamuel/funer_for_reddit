import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:funer_for_reddit/secret/secret.dart';

/*
 * File which contains functions to use to send requests, build urls and headers.
*/
const String oauthUrlBase = "https://www.reddit.com/api/v1";
const String redditBasicUrl = "https://reddit.com/";
const String urlBase = "https://oauth.reddit.com";
const String apiV1 = "/api/v1";

// Used for auth headers.
final String basicAuth =
    "Basic " + base64Encode(utf8.encode('$CLIENT_ID:$PASSWORD'));

// Authentification headers.
final Map<String, String> defaultAuthHeaders = {
  "Authorization": basicAuth,
  'Content-Type': 'application/x-www-form-urlencoded',
};

// Default headers for authentificated requests.
dynamic buildHeadersFromToken(String accessToken) {
  return {
    "Authorization": 'bearer ' + accessToken,
    'Content-Type': 'application/x-www-form-urlencoded',
    'User-Agent': USER_AGENT,
  };
}

// Url builder for authentification.
String authUrlBuilder(String endpoint) {
  String realEndpoint = endpoint;
  if (!endpoint.startsWith("/")) realEndpoint = "/" + endpoint;
  return oauthUrlBase + realEndpoint;
}

// Url builder for reddit.com requests (non auth).
String nonOauthUrlBuilder(String endpoint) {
  String realEndpoint = endpoint;
  if (!endpoint.startsWith("/")) realEndpoint = "/" + endpoint;
  return redditBasicUrl + realEndpoint;
}

// Url builder for basic authentificated requests.
String urlBuilder(String endpoint, {bool isApiV1 = false}) {
  String realEndpoint = endpoint;
  if (!endpoint.startsWith("/")) realEndpoint = "/" + endpoint;
  return urlBase + (isApiV1 ? apiV1 : "") + realEndpoint;
}

Future<http.Response> buildRequestAndPost(String url,
    {bool useAuthHeaders = false,
    String accessToken = "",
    Map<String, String> headers,
    dynamic body}) async {
  var usedHeaders;
  if (headers != null)
    usedHeaders = headers;
  else if (useAuthHeaders)
    usedHeaders = defaultAuthHeaders;
  else {
    usedHeaders = buildHeadersFromToken(accessToken);
  }
  return await httpPost(url, usedHeaders, body);
}

Future<http.Response> httpPost(
    String url, Map<String, String> headers, dynamic body) async {
  return await http.post(url, headers: headers, body: body);
}

Future<http.Response> buildRequestAndGet(String url,
    {String accessToken = "", Map<String, String> headers}) async {
  return await httpGet(
      url, headers != null ? headers : buildHeadersFromToken(accessToken));
}

Future<http.Response> httpGet(String url, Map<String, String> headers) async {
  return await http.get(url, headers: headers);
}
