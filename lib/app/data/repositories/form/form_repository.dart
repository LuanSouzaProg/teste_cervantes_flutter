import '../../../domain/models/form_model.dart';
import '../../../shared/utils/state.dart';

abstract class FormRepository {
  Future<ViewState> getForms();

  Future<ViewState> createForm(FormModel formModel);

  Future<ViewState> updateForm(FormModel formModel);

  Future<ViewState> deleteForm(int id);
}
