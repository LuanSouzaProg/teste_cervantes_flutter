import 'package:flutter_modular/flutter_modular.dart';

import '../../../data/repositories/form/form_repository.dart';
import '../../../shared/utils/state.dart';
import '../../models/form_model.dart';
import 'form_service.dart';

class FormServiceImpl implements FormService {
  FormRepository formRepository = Modular.get();

  @override
  Future<ViewState> getForms() => formRepository.getForms();

  @override
  Future<ViewState> createForm(FormModel formModel) =>
      formRepository.createForm(formModel);

  @override
  Future<ViewState> updateForm(FormModel formModel) =>
      formRepository.updateForm(formModel);

  @override
  Future<ViewState> deleteForm(int id) => formRepository.deleteForm(id);
}
