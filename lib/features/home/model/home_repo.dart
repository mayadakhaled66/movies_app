import 'package:movies_app/features/home/model/home_response_model.dart';
import 'package:movies_app/network/app_client.dart';
import 'package:movies_app/network/requests/model/error_response_model.dart';
import 'package:movies_app/network/requests/model/request_data_model.dart';
import 'package:movies_app/network/requests/get_request.dart';

class HomeRepo {
  static Future<HomeResponseModel?> getPeopleData(int currentPageIndex) async {
    try {
      dynamic response = await NetworkManager(GetRequest()).executeRequest(
        RequestDataModel(
            url: "person/popular",
            queryParams: {"language": "en-US", "page": currentPageIndex}),
      );
      if (response != null) {
        return HomeResponseModel();
      }
    } on ErrorResponse catch (error) {
      rethrow;
    }
  }
}
