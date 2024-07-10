part of 'home_bloc.dart';

class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<FormModel> forms;

  HomeSuccessState({required this.forms});
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState({required this.message});
}
