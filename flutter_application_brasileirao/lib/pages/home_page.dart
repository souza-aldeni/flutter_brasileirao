import 'package:flutter/material.dart';
import 'package:flutter_application_brasileirao/controllers/theme_controller.dart';
import 'package:flutter_application_brasileirao/models/time.dart';
import 'package:flutter_application_brasileirao/pages/time_page.dart';
import 'package:flutter_application_brasileirao/repositories/times_repository.dart';
import 'package:flutter_application_brasileirao/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: prefer_typing_uninitialized_variables
  var controller = ThemeController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Brasileirão',
            ),
          ),
          actions: [
            PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                itemBuilder: (_) => [
                      PopupMenuItem(
                          onTap: () => controller.changeTheme(),
                          child: ListTile(
                              leading: Obx(() => controller.isDark.value
                                  ? const Icon(Icons.brightness_7)
                                  : const Icon(Icons.brightness_2)),
                              title: Obx(() => controller.isDark.value
                                  ? const Text('Light')
                                  : const Text('Dark')))),
                      PopupMenuItem(
                          onTap: () => context.read<AuthService>().logout(),
                          child: const ListTile(
                              leading: Icon(Icons.logout), title: Text('Sair')))
                    ])
          ],
        ),
        body: Consumer<TimesRepository>(
          builder: (BuildContext context, TimesRepository repositorio,
              Widget? child) {
            return ListView.separated(
              itemCount: repositorio.times.length,
              itemBuilder: (context, index) {
                final List<Time> tabela = repositorio.times;
                return ListTile(
                  leading: Image.network(
                    tabela[index].brasao,
                    width: 40.0,
                  ),
                  title: Text(tabela[index].nome),
                  subtitle: Text('Títulos: ${tabela[index].titulos.length}'),
                  trailing: Text(tabela[index].pontos.toString()),
                  onTap: () {
                    Get.to(
                      () => TimePage(
                          key: Key(tabela[index].nome), time: tabela[index]),
                    );
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              padding: const EdgeInsets.all(16.0),
            );
          },
        ));
  }
}
