import 'package:flutter_application_brasileirao/database/db_database.dart';
import '../models/time.dart';
import '../models/titulo.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TimesRepository extends ChangeNotifier {
  final List<Time> _times = [];

  get times => _times;

  void addTitulos({
    required Time time,
    required Titulo titulo,
  }) async {
    var db = await DBDatabase.instance.database;
    var id = await db.child('BD').push().key;
    await db.child('BD/TITULOS/${time.id}/$id').update({
      'campeonato': titulo.campeonato,
      'ano': titulo.ano,
      'timeid': time.id,
      'id': id
    });
    titulo.timeid = time.id;
    titulo.id = id;
    time.titulos.add(titulo);
    notifyListeners();
  }

  void editTitulo({
    required Titulo titulo,
    required String ano,
    required String campeonato,
  }) async {
    var db = await DBDatabase.instance.database;

    await db.child('BD/TITULOS/${titulo.timeid}/${titulo.id}').update({
      'campeonato': campeonato,
      'ano': ano,
    });
    titulo.ano = ano;
    titulo.campeonato = campeonato;
    notifyListeners();
  }

  TimesRepository() {
    initRepository();
  }

  void initRepository() async {
    var db = await DBDatabase.instance.database;
    final snapshot = await db.child('BD/TIMES').get();
    snapshot.value.forEach((k, v) async {
      _times.add(Time(
        id: v['id'],
        nome: v['nome'],
        brasao: v['brasao'],
        pontos: v['pontos'],
        cor: HexColor("#${v['cor'].toString().substring(39, 45)}"),
        titulos: await getTitulos(k),
      ));
    });
    notifyListeners();
  }

  getTitulos(timeId) async {
    var db = await DBDatabase.instance.database;
    final snapshot = await db.child('BD/TITULOS/$timeId').get();
    List<Titulo> titulos = [];
    if (snapshot.exists) {
      snapshot.value.forEach((k, v) async {
        titulos.add(Titulo(
          id: v['id'],
          campeonato: v['campeonato'],
          ano: v['ano'],
          timeid: v['timeid'],
        ));
      });
    }
    return titulos;
  }

  static setupTimes() {
    return [
      Time(
        nome: 'Flamengo',
        pontos: 57,
        brasao: 'https://logodetimes.com/times/flamengo/logo-flamengo-256.png',
        cor: Colors.red,
        id: '',
      ),
      Time(
        nome: 'Internacional',
        pontos: 68,
        brasao:
            'https://logodetimes.com/times/internacional/logo-internacional-256.png',
        cor: Colors.red,
        id: '',
      ),
      Time(
        nome: 'Atlético-MG',
        pontos: 35,
        brasao:
            'https://logodetimes.com/times/atletico-mineiro/logo-atletico-mineiro-256.png',
        cor: Colors.grey,
        id: '',
      ),
      Time(
        nome: 'São Paulo',
        pontos: 44,
        brasao:
            'https://logodetimes.com/times/sao-paulo/logo-sao-paulo-256.png',
        cor: Colors.red,
        id: '',
      ),
      Time(
        nome: 'Fluminense',
        pontos: 29,
        brasao:
            'https://logodetimes.com/times/fluminense/logo-fluminense-256.png',
        cor: Colors.teal,
        id: '',
      ),
      Time(
        nome: 'Grêmio',
        pontos: 78,
        brasao: 'https://logodetimes.com/times/gremio/logo-gremio-256.png',
        cor: Colors.blue,
        id: '',
      ),
      Time(
        nome: 'Palmeiras',
        pontos: 32,
        brasao:
            'https://logodetimes.com/times/palmeiras/logo-palmeiras-256.png',
        cor: Colors.green,
        id: '',
      ),
      Time(
        nome: 'Santos',
        pontos: 33,
        brasao: 'https://logodetimes.com/times/santos/logo-santos-256.png',
        cor: Colors.grey,
        id: '',
      ),
      Time(
        nome: 'Athletico-PR',
        pontos: 14,
        brasao:
            'https://logodetimes.com/times/atletico-paranaense/logo-atletico-paranaense-256.png',
        cor: Colors.red,
        id: '',
      ),
      Time(
        nome: 'Corinthians',
        pontos: 47,
        brasao:
            'https://logodetimes.com/times/corinthians/logo-corinthians-256.png',
        cor: Colors.grey,
        id: '',
      ),
      Time(
        nome: 'Bragantino',
        pontos: 89,
        brasao:
            'https://logodetimes.com/times/red-bull-bragantino/logo-red-bull-bragantino-256.png',
        cor: Colors.grey,
        id: '',
      ),
      Time(
        nome: 'Ceará',
        pontos: 30,
        brasao: 'https://logodetimes.com/times/ceara/logo-ceara-256.png',
        cor: Colors.grey,
        id: '',
      ),
      Time(
        nome: 'Atlético-GO',
        pontos: 0,
        brasao:
            'https://logodetimes.com/times/atletico-goianiense/logo-atletico-goianiense-256.png',
        cor: Colors.red,
        id: '',
      ),
      Time(
        nome: 'Sport',
        pontos: 56,
        brasao:
            'https://logodetimes.com/times/sport-recife/logo-sport-recife-256.png',
        cor: Colors.red,
        id: '',
      ),
      Time(
        nome: 'Bahia',
        pontos: 38,
        brasao: 'https://logodetimes.com/times/bahia/logo-bahia-256.png',
        cor: Colors.blue,
        id: '',
      ),
      Time(
        nome: 'Fortaleza',
        pontos: 46,
        brasao:
            'https://logodetimes.com/times/fortaleza/logo-fortaleza-256.png',
        cor: Colors.red,
        id: '',
      ),
      Time(
        nome: 'Vasco',
        pontos: 55,
        brasao:
            'https://logodetimes.com/times/vasco-da-gama/logo-vasco-da-gama-256.png',
        cor: Colors.grey,
        id: '',
      ),
      Time(
        nome: 'Goiás',
        pontos: 28,
        brasao:
            'https://logodetimes.com/times/goias/logo-goias-esporte-clube-256.png',
        cor: Colors.green,
        id: '',
      ),
      Time(
        nome: 'Coritiba',
        pontos: 44,
        brasao: 'https://logodetimes.com/times/coritiba/logo-coritiba-5.png',
        cor: Colors.green,
        id: '',
      ),
      Time(
        nome: 'Botafogo',
        pontos: 72,
        brasao: 'https://logodetimes.com/times/botafogo/logo-botafogo-256.png',
        cor: Colors.grey,
        id: '',
      ),
    ];
  }
}
