import 'package:flutter_modular/flutter_modular.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

import '../../../domain/services/form/form_service.dart';
import '../../../domain/models/form_model.dart';
import '../../../shared/utils/state.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  FormService formService = Modular.get();

  UpdateBloc() : super(UpdateInitialState()) {
    on<UpdateEvent>((event, emit) async {
      emit(UpdateLoadingState());
      await handleUpdateForms(event, emit);
    });
  }

  Future handleUpdateForms(event, emit) async {
    var response = await formService.updateForm(event.form);

    if (response is Success) {
      emit(UpdateSuccessState());
    } else if (response is Failure) {
      emit(
        UpdateErrorState(message: response.message ?? ''),
      );
    }
  }
}
