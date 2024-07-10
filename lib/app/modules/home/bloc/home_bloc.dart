import 'package:flutter_modular/flutter_modular.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

import '../../../domain/services/form/form_service.dart';
import '../../../domain/models/form_model.dart';
import '../../../shared/utils/state.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  FormService formService = Modular.get();

  HomeBloc() : super(HomeInitialState()) {
    on<GetFormsEvent>((event, emit) async {
      emit(HomeLoadingState());
      await handleGetForms(event, emit);
    });

    on<CreateFormEvent>((event, emit) async {
      emit(HomeLoadingState());
      await handleCreateForms(event, emit);
    });

    on<DeleteFormEvent>((event, emit) async {
      emit(HomeLoadingState());
      await handleDeleteForms(event, emit);
    });
  }

  Future handleGetForms(event, emit) async {
    var response = await formService.getForms();

    if (response is Success) {
      emit(
        HomeSuccessState(forms: response.data),
      );
    } else if (response is Failure) {
      emit(
        HomeErrorState(message: response.message ?? ''),
      );
    }
  }

  Future handleCreateForms(event, emit) async {
    var response = await formService.createForm(event.form);

    if (response is Success) {
      await handleGetForms(event, emit);
    } else if (response is Failure) {
      emit(
        HomeErrorState(message: response.message ?? ''),
      );
    }
  }

  Future handleDeleteForms(event, emit) async {
    var response = await formService.deleteForm(event.id);

    if (response is Success) {
      await handleGetForms(event, emit);
    } else if (response is Failure) {
      emit(
        HomeErrorState(message: response.message ?? ''),
      );
    }
  }
}
