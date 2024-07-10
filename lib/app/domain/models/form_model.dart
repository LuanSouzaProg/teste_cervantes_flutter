// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FormModel {
  final int? id;
  final String texto;
  final int numero;
  FormModel({
    this.id,
    required this.texto,
    required this.numero,
  });

  FormModel copyWith({
    int? id,
    String? texto,
    int? numero,
  }) {
    return FormModel(
      id: id ?? this.id,
      texto: texto ?? this.texto,
      numero: numero ?? this.numero,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'texto': texto,
      'numero': numero,
    };
  }

  factory FormModel.fromMap(Map<String, dynamic> map) {
    return FormModel(
      id: map['id'] != null ? map['id'] as int : null,
      texto: map['texto'] as String,
      numero: map['numero'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormModel.fromJson(String source) =>
      FormModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FormModel(id: $id, texto: $texto, numero: $numero)';

  @override
  bool operator ==(covariant FormModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.texto == texto && other.numero == numero;
  }

  @override
  int get hashCode => id.hashCode ^ texto.hashCode ^ numero.hashCode;
}
