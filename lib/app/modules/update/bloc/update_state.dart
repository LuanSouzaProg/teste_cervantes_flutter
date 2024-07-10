part of 'update_bloc.dart';

class UpdateState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateInitialState extends UpdateState {}

class UpdateLoadingState extends UpdateState {}

class UpdateSuccessState extends UpdateState {}

class UpdateErrorState extends UpdateState {
  final String message;

  UpdateErrorState({required this.message});
}
