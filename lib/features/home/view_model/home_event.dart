part of 'home_bloc.dart';

class HomeEvent {}

class LoadPopularPeopleEvent extends HomeEvent {
  int currentIndex;

  LoadPopularPeopleEvent(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}

class LoadPopularPeopleDetailsEvent extends HomeEvent {
  int personID;
  LoadPopularPeopleDetailsEvent(this.personID);

  @override
  List<Object> get props => [personID];
}
