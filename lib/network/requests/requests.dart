import 'package:dio/dio.dart';
import 'package:movies_app/network/requests/model/request_data_model.dart';

abstract class AppRequests{
  Future<dynamic> sendRequest (Dio dio,RequestDataModel requestDataModel);
}