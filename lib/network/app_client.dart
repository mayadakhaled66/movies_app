import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movies_app/network/requests/model/error_response_model.dart';
import 'package:movies_app/network/requests/model/request_data_model.dart';
import 'package:movies_app/network/requests/requests.dart';
import 'package:movies_app/utilities/app_constants.dart';

class NetworkManager {
  AppRequests? _appRequests;

  static Dio addInterceptors(Dio dio) {
    return dio..interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options,RequestInterceptorHandler handler) => _logRequestData(options),
        onResponse: (Response response,_) => _logResponseData(response),
        onError: (DioError dioError,_) => _logErrorData(dioError)));
  }

  NetworkManager(AppRequests appRequests) {
    _appRequests = appRequests;
  }

  Future<dynamic> executeRequest(RequestDataModel requestDataModel) async {
    try {
      _prepareRequestOptions(requestDataModel);
      return await _appRequests?.sendRequest(requestDataModel);
    } on ErrorResponse catch (e) {
      rethrow;
    }
  }

  void _prepareRequestOptions(RequestDataModel requestDataModel) {
    if (requestDataModel.queryParams != null) {
      requestDataModel.queryParams?.addAll({"api_key": AppConstants.apiKey});
    } else {
      requestDataModel.queryParams = {"api_key": AppConstants.apiKey};
    }
  }

  static String _logRequestData(RequestOptions request){
    return "----- request -----:\nUrl: ${request.path}\nqueryParam: ${request.queryParameters}\nheaders: ${request.headers} body: ${request.data}\n";
  }
  static String _logResponseData(Response response){
    return "----- response -----:\nstatusCode ${response.statusCode}\ndata: ${response.data}";
  }
  static String _logErrorData(DioError dioError){
    return "----- Error response -----: \nmessage: ${dioError.message}\nresponse ${dioError.response}";
  }
}
