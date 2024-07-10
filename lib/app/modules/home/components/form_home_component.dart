import 'package:validatorless/validatorless.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/form_model.dart';
import '../bloc/home_bloc.dart';

class FormHomeComponent extends StatefulWidget {
  final HomeBloc bloc;

  const FormHomeComponent({
    super.key,
    required this.bloc,
  });

  @override
  State<FormHomeComponent> createState() => _FormHomeComponentState();
}

class _FormHomeComponentState extends State<FormHomeComponent> {
  final formHomeKey = GlobalKey<FormState>();

  TextEditingController textController = TextEditingController();
  TextEditingController numController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formHomeKey,
      child: Column(
        children: [
          const SizedBox(height: 30),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Campo texto',
              hintText: 'Insira o texto',
              border: OutlineInputBorder(),
            ),
            validator: Validatorless.required(
              'Esse campos deve ser preenchido!',
            ),
            controller: textController,
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Campo numérico',
              hintText: 'Insira o número',
              border: OutlineInputBorder(),
            ),
            validator: Validatorless.multiple(
              [
                Validatorless.required('Esse campos deve ser preenchido!'),
                Validatorless.number('Esse campo aceita apenas números!'),
                Validatorless.regex(
                  RegExp(r'^[1-9]\d*$'),
                  'Esse campo aceita apenas números maiores que 0!',
                ),
              ],
            ),
            controller: numController,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              if (formHomeKey.currentState!.validate()) {
                widget.bloc.add(
                  CreateFormEvent(
                    form: FormModel(
                      texto: textController.text,
                      numero: int.tryParse(numController.text) ?? 0,
                    ),
                  ),
                );

                textController.clear();
                numController.clear();
              }
            },
            child: const Text(
              'Criar',
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
