import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../components/form_update_component.dart';
import '../../../domain/models/form_model.dart';
import '../../home/bloc/home_bloc.dart';
import '../bloc/update_bloc.dart';

class UpdatePage extends StatefulWidget {
  final FormModel form;

  const UpdatePage({
    super.key,
    required this.form,
  });

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  HomeBloc homeBloc = Modular.get();
  UpdateBloc bloc = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update'),
      ),
      body: BlocListener<UpdateBloc, UpdateState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is UpdateErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }

          if (state is UpdateSuccessState) {
            homeBloc.add(GetFormsEvent());

            Modular.to.pop();
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Column(
            children: [
              FormUpdateComponent(
                bloc: bloc,
                form: widget.form,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
