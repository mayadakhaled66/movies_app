import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movies_app/network/app_client.dart';
import 'package:movies_app/network/requests/model/error_response_model.dart';
import 'package:movies_app/network/requests/model/request_data_model.dart';
import 'package:movies_app/network/requests/requests.dart';
import 'package:movies_app/utilities/app_constants.dart';

class PostRequest implements AppRequests {
  @override
  Future<dynamic> sendRequest(
      Dio dio, RequestDataModel requestDataModel) async {
    try {
      log("----- request -----:\nUrl: ${requestDataModel.url}\nqueryParam: ${requestDataModel.queryParams}\nheaders: ${requestDataModel.headers} body: ${requestDataModel.body}\n");
      final response = await dio.post(
          AppConstants.baseUrl + requestDataModel.url,
          data: requestDataModel.body,
          queryParameters: requestDataModel.queryParams,
          options: Options(
              headers: requestDataModel.headers, receiveTimeout: 50000));
      log("----- response -----:\nstatusCode ${response.statusCode}\ndata: ${response.data}");
      if (response != null) {
        return response.data;
      }
    } on DioError catch (error) {
      log("----- Error response -----: \nmessage: ${error.message}\nresponse ${error.response}");

      throw ErrorResponse(errorCode: "", errorMessage: error.message);
    }
  }
}
