import 'package:dio/dio.dart';
import 'package:movies_app/network/requests/model/error_response_model.dart';
import 'package:movies_app/network/requests/model/request_data_model.dart';
import 'package:movies_app/network/requests/requests.dart';
import 'package:movies_app/utilities/app_constants.dart';

class PostRequest implements AppRequests {
  @override
  Future<dynamic> sendRequest(RequestDataModel requestDataModel) async {
    try {
      dynamic response = await Dio().post(
          AppConstants.baseUrl + requestDataModel.url,
          data: requestDataModel.body,
          queryParameters: requestDataModel.queryParams,
          options: Options(
              headers: requestDataModel.headers, receiveTimeout: 50000));
      if (response != null) {
        return response;
      }
    } on DioError catch (error) {
      throw ErrorResponse(errorCode: "", errorMessage: error.message);
    }
  }
}
