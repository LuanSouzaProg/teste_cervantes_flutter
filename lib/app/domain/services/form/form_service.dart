import '../../../shared/utils/state.dart';
import '../../models/form_model.dart';

abstract class FormService {
  Future<ViewState> getForms();

  Future<ViewState> createForm(FormModel formModel);

  Future<ViewState> updateForm(FormModel formModel);

  Future<ViewState> deleteForm(int id);
}
