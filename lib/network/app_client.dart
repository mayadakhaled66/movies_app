import 'package:movies_app/network/requests/model/error_response_model.dart';
import 'package:movies_app/network/requests/model/request_data_model.dart';
import 'package:movies_app/network/requests/requests.dart';
import 'package:movies_app/utilities/app_constants.dart';

class NetworkManager {
  AppRequests? _appRequests;

  NetworkManager(AppRequests appRequests) {
    _appRequests = appRequests;
  }

  Future<dynamic> executeRequest(RequestDataModel requestDataModel) async {
    try {
      prepareRequestOptions(requestDataModel);
      return await _appRequests?.sendRequest(requestDataModel);
    } on ErrorResponse catch (e) {
      rethrow;
    }
  }

  void prepareRequestOptions(RequestDataModel requestDataModel) {
    if (requestDataModel.queryParams != null) {
      requestDataModel.queryParams?.addAll({"api_key": AppConstants.apiKey});
    } else {
      requestDataModel.queryParams = {"api_key": AppConstants.apiKey};
    }
  }
}
