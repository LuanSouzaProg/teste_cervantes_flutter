import 'package:flutter_modular/flutter_modular.dart';

import 'data/repositories/form/form_repository_impl.dart';
import 'data/repositories/form/form_repository.dart';
import 'domain/services/form/form_service_imp.dart';
import 'modules/update/module/update_module.dart';
import 'domain/services/form/form_service.dart';
import 'modules/home/module/home_module.dart';
import 'modules/update/bloc/update_bloc.dart';
import 'modules/home/bloc/home_bloc.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.add<FormRepository>(FormRepositoryImpl.new);
    i.add<FormService>(FormServiceImpl.new);
    i.addSingleton(UpdateBloc.new);
    i.addSingleton(HomeBloc.new);
  }

  @override
  void routes(r) {
    r.module('/', module: HomeModule());
    r.module('/update', module: UpdateModule());
  }
}
