part of 'update_bloc.dart';

class UpdateEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateFormEvent extends UpdateEvent {
  final FormModel form;

  UpdateFormEvent({required this.form});
}
