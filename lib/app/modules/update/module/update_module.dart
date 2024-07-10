import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/bloc/home_bloc.dart';
import '../bloc/update_bloc.dart';
import '../page/update_page.dart';

class UpdateModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) {
        UpdateBloc updateBloc = Modular.get();
        HomeBloc homeBloc = Modular.get();

        return MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: updateBloc,
            ),
            BlocProvider.value(
              value: homeBloc,
            ),
          ],
          child: UpdatePage(
            form: r.args.data,
          ),
        );
      },
    );
  }
}
