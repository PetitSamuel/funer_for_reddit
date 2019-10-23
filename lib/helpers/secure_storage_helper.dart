import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  final _storage = new FlutterSecureStorage();
  Map<String, dynamic> map;

  SecureStorageHelper() {
    init();
  }

  Future<void> init() async {
    await fetchData();
  }

  Future<String> get accessToken async {
    await fetchData();
    return map['accessToken'];
  }

  String get debugPrint => map.toString();

  Future<String> get refreshToken async {
    await fetchData();
    return map['refreshToken'];
  }

  Future<String> get lastTokenRefresh async {
    await fetchData();
    return map['lastTokenRefresh'];
  }

  bool get signInStatus {
    if (map != null)
      return (map.containsKey('signedIn') && map['signedIn'] == "true");
    else {
      return false;
    }
  }

  Future<bool> needsTokenRefresh() async {
    String lastRefresh = await lastTokenRefresh;
    if (lastRefresh.isEmpty) {
      return true;
    }
    Duration time = (DateTime.now()).difference(DateTime.parse(lastRefresh));
    print(time.toString());
    return time.inMinutes > 50;
  }

  Future<void> updateCredentials(
    String accessToken,
    String refreshToken,
    bool signedIn,
  ) async {
    await _storage.write(key: "accessToken", value: accessToken);
    await _storage.write(key: "refreshToken", value: refreshToken);
    await _storage.write(key: "signedIn", value: signedIn.toString());
    await _storage.write(
      key: "lastTokenRefresh",
      value: getDateAsString(),
    );

    await fetchData();
  }

  String getDateAsString() {
    return DateTime.now().toIso8601String();
  }

  Future<void> updateAccessToken(String accessToken) async {
    map['accessToken'] = accessToken;
    await _storage.write(key: 'accessToken', value: accessToken);
    await _storage.write(
      key: 'lastTokenRefresh',
      value: getDateAsString(),
    );
    await _storage.write(
      key: 'signedIn',
      value: true.toString(),
    );
  }

  Future<void> fetchData() async {
    map = await _storage.readAll();
  }

  Future<void> clearStorage() async {
    map = new Map<String, dynamic>();
    await _storage.deleteAll();
    await fetchData();
  }
}
