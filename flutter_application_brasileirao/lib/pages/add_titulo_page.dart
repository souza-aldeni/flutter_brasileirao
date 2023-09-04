import 'package:flutter/material.dart';
import 'package:flutter_application_brasileirao/models/time.dart';
import 'package:flutter_application_brasileirao/models/titulo.dart';
import 'package:flutter_application_brasileirao/repositories/times_repository.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddTituloPage extends StatefulWidget {
  Time time;

  AddTituloPage({super.key, required this.time});

  @override
  State<AddTituloPage> createState() => _AddTituloPageState();
}

class _AddTituloPageState extends State<AddTituloPage> {
  final _campeonato = TextEditingController();
  final _ano = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  save() {
    Provider.of<TimesRepository>(context, listen: false).addTitulos(
        time: widget.time,
        titulo: Titulo(
          ano: _ano.text,
          campeonato: _campeonato.text,
        ));
    Get.back();
    Get.snackbar('Sucesso!', 'Título cadastrado!',
        backgroundColor: Colors.grey[700],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Título'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextFormField(
                controller: _ano,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Ano'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o ano do título!';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextFormField(
                controller: _campeonato,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Campeonato'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o campeonato!';
                  }
                  return null;
                },
              ),
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(12.0),
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      save();
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Salvar',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  )),
            ))
          ],
        ),
      ),
    );
  }
}
