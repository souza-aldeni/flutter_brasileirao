import 'package:flutter/material.dart';
import 'package:flutter_application_brasileirao/models/titulo.dart';
import 'package:flutter_application_brasileirao/repositories/times_repository.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditTituloPage extends StatefulWidget {
  Titulo titulo;
  EditTituloPage({super.key, required this.titulo});

  @override
  State<EditTituloPage> createState() => _EditTituloPageState();
}

class _EditTituloPageState extends State<EditTituloPage> {
  final _campeonato = TextEditingController();
  final _ano = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _ano.text = widget.titulo.ano;
    _campeonato.text = widget.titulo.campeonato;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Título'),
        backgroundColor: Colors.grey[800],
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () => editar(),
          )
        ],
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
          ],
        ),
      ),
    );
  }

  editar() {
    Provider.of<TimesRepository>(context, listen: false).editTitulo(
      titulo: widget.titulo,
      campeonato: _campeonato.text,
      ano: _ano.text,
    );
    Get.back();
    Get.snackbar('Sucesso!', 'Título alterado!',
        backgroundColor: Colors.grey[700],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }
}
