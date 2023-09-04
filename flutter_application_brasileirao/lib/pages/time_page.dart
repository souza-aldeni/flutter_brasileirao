import 'package:flutter/material.dart';
import 'package:flutter_application_brasileirao/controllers/theme_controller.dart';
import 'package:flutter_application_brasileirao/pages/edit_titulo_page.dart';
import 'package:flutter_application_brasileirao/repositories/times_repository.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../models/time.dart';
import '../pages/add_titulo_page.dart';

// ignore: must_be_immutable
class TimePage extends StatefulWidget {
  Time time;
  TimePage({super.key, required this.time});

  @override
  State<TimePage> createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  var controller = ThemeController.to;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: controller.isDark.value ? null : widget.time.cor,
          title: Text(widget.time.nome),
          bottom: const TabBar(indicatorColor: Colors.white, tabs: [
            Tab(icon: Icon(Icons.stacked_bar_chart), text: 'Estatística'),
            Tab(icon: Icon(Icons.emoji_events), text: 'Títulos'),
          ]),
          actions: [
            IconButton(
                icon: const Icon(Icons.add), onPressed: () => tituloPage())
          ],
        ),
        body: TabBarView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(widget.time.brasao),
                Text(
                  'Pontos: ${widget.time.pontos}',
                  style: const TextStyle(fontSize: 22.0),
                )
              ],
            ),
            titulos(),
          ],
        ),
      ),
    );
  }

  Widget titulos() {
    final time = Provider.of<TimesRepository>(context)
        .times
        .firstWhere((element) => element.nome == widget.time.nome);

    final quantidade = time.titulos.length;

    return quantidade == 0
        ? const Center(
            child: Text('Nenhum título ainda'),
          )
        : ListView.separated(
            itemCount: quantidade,
            itemBuilder: (context, index) => ListTile(
              leading: const Icon(Icons.emoji_events),
              title: Text(time.titulos[index].campeonato),
              trailing: Text(time.titulos[index].ano),
              onTap: () {
                Get.to(EditTituloPage(titulo: time.titulos[index]));
              },
            ),
            separatorBuilder: (context, index) => const Divider(),
          );
  }

  tituloPage() {
    Get.to(AddTituloPage(time: widget.time));
  }
}
