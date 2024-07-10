part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetFormsEvent extends HomeEvent {}

class CreateFormEvent extends HomeEvent {
  final FormModel form;

  CreateFormEvent({required this.form});
}

class DeleteFormEvent extends HomeEvent {
  final int id;

  DeleteFormEvent({required this.id});
}
