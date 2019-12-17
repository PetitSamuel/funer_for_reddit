import 'dart:io';
import 'dart:async';

class LocalServer {
  final String code;

  LocalServer({this.code});
  // listen to local host requests & return a stream containing the access code & the uuid.
  Future<Stream<String>> server() async {
    final StreamController<String> onCode = new StreamController();
    HttpServer server =
        await HttpServer.bind(InternetAddress.loopbackIPv4, 8080, shared: true);
    server.listen((HttpRequest request) async {
      final String code = request.uri.queryParameters["code"];
      final String state = request.uri.queryParameters["state"];

      onCode.add(code);
      onCode.add(state);

      request.response
        ..statusCode = 200
        ..headers.set("Content-Type", ContentType.html.mimeType)
        ..write(
            "<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><h1 style='margin: 0 auto; height:100%; text-align:center;'>Redirecting back to the app.</h1></html>");
      await request.response.close();
      await server.close(force: true);
      await onCode.close();
    });
    return onCode.stream;
  }
}
