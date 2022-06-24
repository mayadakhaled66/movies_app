
import 'package:bloc/bloc.dart';
import 'package:movies_app/features/home/model/home_repo.dart';
import 'package:movies_app/features/home/model/home_response_model.dart';
import 'package:movies_app/features/home/model/person_details_model.dart';
import 'package:movies_app/network/requests/model/error_response_model.dart';
import 'package:movies_app/utilities/app_constants.dart';
import 'package:movies_app/utilities/app_shared_prefrences.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomePageInitial()) {
    on<LoadPopularPeopleEvent>((event, emit) async {
      try {
        emit(HomePageLoading());
        List<String> cachedList =
        await AppSharePreferences.getListOfData(AppConstants.personsKey);
        HomeResponseModel? popularPeopleListModel;
        if(cachedList.isNotEmpty&&cachedList.length >=event.currentIndex){
          popularPeopleListModel= HomeResponseModel.fromRawJson(cachedList[event.currentIndex-1]);
        }else{
          popularPeopleListModel =
          await HomeRepo.getPeopleData(event.currentIndex);
          if(popularPeopleListModel!=null){
            AppSharePreferences.addListOfData(AppConstants.personsKey,popularPeopleListModel.toRawJson());
          }
        }
        if (popularPeopleListModel != null) {
          emit(HomePageSuccessState(popularPeopleListModel));
        } else {
          emit(HomePageFail(error: "no Data :("));
        }
      } on ErrorResponse catch (error) {
        emit(HomePageFail(error: error.errorMessage.toString()));
      }
    });

    on<LoadPopularPeopleDetailsEvent>((event, emit) async {
      try {
        emit(HomePageLoading());
        PersonDetailsResponseModel? popularPeopleListModel =
        await HomeRepo.getPeopleDetailsData(event.personID);
        if (popularPeopleListModel != null) {
          emit(PersonDetailsSuccessState(popularPeopleListModel));
        } else {
          emit(HomePageFail(error: "no Data :("));
        }
      } on ErrorResponse catch (error) {
        emit(HomePageFail(error: error.errorMessage.toString()));
      }
    });
  }


}
