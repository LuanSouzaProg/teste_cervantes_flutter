import '../../../shared/helpers/data_base_helper.dart';
import '../../../domain/models/form_model.dart';
import '../../../shared/utils/state.dart';
import 'form_repository.dart';

class FormRepositoryImpl implements FormRepository {
  final db = DatabaseHelper();

  @override
  Future<ViewState> getForms() async {
    try {
      List<FormModel> response = await db.getCadastros();

      List<Map<String, dynamic>> logs = await db.getLogs();

      print(logs);

      return Success(data: response);
    } catch (e) {
      return Failure(message: e.toString());
    }
  }

  @override
  Future<ViewState> createForm(FormModel formModel) async {
    try {
      await db.insertCadastro(formModel.texto, formModel.numero);

      return Success();
    } catch (e) {
      return Failure(message: e.toString());
    }
  }

  @override
  Future<ViewState> updateForm(FormModel formModel) async {
    try {
      await db.updateCadastro(
          formModel.id ?? 0, formModel.texto, formModel.numero);

      return Success();
    } catch (e) {
      return Failure(message: e.toString());
    }
  }

  @override
  Future<ViewState> deleteForm(int id) async {
    try {
      await db.deleteCadastro(id);

      return Success();
    } catch (e) {
      return Failure(message: e.toString());
    }
  }
}
