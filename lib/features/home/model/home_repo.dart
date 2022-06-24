import 'package:movies_app/features/home/model/home_response_model.dart';
import 'package:movies_app/features/home/model/person_details_model.dart';
import 'package:movies_app/network/app_client.dart';
import 'package:movies_app/network/requests/model/error_response_model.dart';
import 'package:movies_app/network/requests/model/request_data_model.dart';
import 'package:movies_app/network/requests/get_request.dart';

class HomeRepo {
  static Future<HomeResponseModel?> getPeopleData(int currentPageIndex) async {
    try {
      Map<String, dynamic> response = await NetworkManager(GetRequest()).executeRequest(
        RequestDataModel(
            url: "person/popular",
            queryParams: {"language": "en-US", "page": currentPageIndex}),
      );
      if (response != null) {
        return HomeResponseModel.fromJson(response);
      }
    } on ErrorResponse catch (error) {
      rethrow;
    }
  }
  static Future<PersonDetailsResponseModel?> getPeopleDetailsData(int personID) async {
    try {
      Map<String, dynamic> response = await NetworkManager(GetRequest()).executeRequest(
        RequestDataModel(
            url: "person/$personID",
            queryParams: {"language": "en-US"}),
      );
      if (response != null) {
        return PersonDetailsResponseModel.fromJson(response);
      }
    } on ErrorResponse catch (error) {
      rethrow;
    }
  }
}
