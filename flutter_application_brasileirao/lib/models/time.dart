import 'package:flutter/material.dart';
import 'package:flutter_application_brasileirao/models/titulo.dart';

class Time {
  String id;
  String nome;
  String brasao;
  int pontos;
  Color cor;
  List<Titulo> titulos;

  Time(
      {required this.brasao,
      required this.nome,
      required this.pontos,
      required this.cor,
      required this.id,
      this.titulos = const <Titulo>[]});
}
