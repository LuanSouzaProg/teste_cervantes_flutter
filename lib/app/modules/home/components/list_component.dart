import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/form_model.dart';
import '../bloc/home_bloc.dart';

class ListComponent extends StatefulWidget {
  final HomeBloc bloc;
  final List<FormModel> list;

  const ListComponent({
    super.key,
    required this.list,
    required this.bloc,
  });

  @override
  State<ListComponent> createState() => _ListComponentState();
}

class _ListComponentState extends State<ListComponent> {
  @override
  Widget build(BuildContext context) {
    return widget.list.isEmpty
        ? Center(
            child: SvgPicture.asset('assets/imgs/empty.svg', width: 200),
          )
        : ListView.builder(
            itemCount: widget.list.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.black12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.05,
                            alignment: Alignment.center,
                            child: Text(
                              widget.list[index].id.toString(),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Text(
                              'Texto: ${widget.list[index].texto}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Text(
                              'Número: ${widget.list[index].numero}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Modular.to.pushNamed(
                                '/update/',
                                arguments: widget.list[index],
                              );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              widget.bloc.add(
                                DeleteFormEvent(
                                  id: widget.list[index].id!,
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
