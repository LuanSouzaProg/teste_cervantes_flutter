import 'package:validatorless/validatorless.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/form_model.dart';
import '../bloc/update_bloc.dart';

class FormUpdateComponent extends StatefulWidget {
  final UpdateBloc bloc;
  final FormModel form;

  const FormUpdateComponent({
    super.key,
    required this.bloc,
    required this.form,
  });

  @override
  State<FormUpdateComponent> createState() => _FormUpdateComponentState();
}

class _FormUpdateComponentState extends State<FormUpdateComponent> {
  final formUpdateKey = GlobalKey<FormState>();
  TextEditingController textUpdateController = TextEditingController();
  TextEditingController numUpdateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formUpdateKey,
      child: Column(
        children: [
          const SizedBox(height: 30),
          TextFormField(
            initialValue: widget.form.texto,
            decoration: const InputDecoration(
              labelText: 'Campo texto',
              border: OutlineInputBorder(),
            ),
            validator: Validatorless.required(
              'Esse campos deve ser preenchido!',
            ),
            onChanged: (value) {
              textUpdateController.text = value;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: widget.form.numero.toString(),
            decoration: const InputDecoration(
              labelText: 'Campo numérico',
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
            onChanged: (value) {
              numUpdateController.text = value;
            },
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              if (formUpdateKey.currentState!.validate()) {
                widget.bloc.add(
                  UpdateFormEvent(
                    form: FormModel(
                      id: widget.form.id,
                      texto: textUpdateController.text.isNotEmpty
                          ? textUpdateController.text
                          : widget.form.texto,
                      numero: int.tryParse(
                            numUpdateController.text.isNotEmpty
                                ? numUpdateController.text
                                : widget.form.numero.toString(),
                          ) ??
                          0,
                    ),
                  ),
                );
              }
            },
            child: const Text(
              'Atualizar',
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
