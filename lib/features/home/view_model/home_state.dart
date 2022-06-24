part of 'home_bloc.dart';

class HomeState {
  @override
  List<Object> get props => [];
}

class HomePageInitial extends HomeState {}

class HomePageLoading extends HomeState {
  // @override
  // List<Object> get props => [];
}

class HomePageSuccessState extends HomeState {
  HomeResponseModel model;

  HomePageSuccessState(this.model);

  @override
  List<Object> get props => [model];
}

class PersonDetailsSuccessState extends HomeState {
  PersonDetailsResponseModel model;

  PersonDetailsSuccessState(this.model);

  @override
  List<Object> get props => [model];
}

class HomePageFail extends HomeState {
  final String error;

  HomePageFail({required this.error});

  @override
  List<Object> get props => [error];
}
