
import 'package:movies_app/network/requests/requests.dart';

enum RequestType { get, post }

class RequestDataModel {
  String url;
  Map<String, dynamic>? body;
  Map<String, dynamic>? headers;
  Map<String, dynamic>? queryParams;

  RequestDataModel(
      {required this.url,
      this.body,
      this.headers,
      this.queryParams});
}
