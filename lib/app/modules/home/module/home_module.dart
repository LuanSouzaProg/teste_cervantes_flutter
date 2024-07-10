import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';
import '../page/home_page.dart';

class HomeModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) {
        HomeBloc homeBloc = Modular.get();

        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: homeBloc),
          ],
          child: const HomePage(),
        );
      },
    );
  }
}
