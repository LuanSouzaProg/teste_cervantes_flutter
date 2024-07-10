import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/form_home_component.dart';
import '../components/list_component.dart';
import '../bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc bloc = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 60,
          ),
          child: Column(
            children: [
              FormHomeComponent(
                bloc: bloc,
              ),
              Container(
                height: 400,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: BlocBuilder<HomeBloc, HomeState>(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is HomeInitialState) {
                      bloc.add(GetFormsEvent());
                    }

                    if (state is HomeLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is HomeSuccessState) {
                      return ListComponent(
                        list: state.forms,
                        bloc: bloc,
                      );
                    }

                    if (state is HomeErrorState) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(state.message),
                            const SizedBox(height: 30),
                            SvgPicture.asset(
                              'assets/imgs/error.svg',
                              width: 200,
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () {
                                bloc.add(GetFormsEvent());
                              },
                              child: const Text(
                                'Recuperar Lista',
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
