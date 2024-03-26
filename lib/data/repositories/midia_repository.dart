import 'dart:convert';
import 'package:globoplay_mobile/data/http/http_client.dart';
import 'package:globoplay_mobile/domain/models/midia.dart';

abstract class IMidiaRepository {
  getNovelas();
  getSeries();
  getMovies();
  getMidiabyId(); //more details
}

class MidiaRepository implements IMidiaRepository {
  final IHttpClient client;

  final baseUrl = const String.fromEnvironment('BASE_URL');
  final apiKey = const String.fromEnvironment('API_KEY');

  MidiaRepository({required this.client});

  @override
  Future getNovelas() async {
    final response = await client.get(
        url:
            'https://api.themoviedb.org/3/discover/tv?language=pt-BR&with_networks=3290&api_key=f5584caeecdbc0937682e809bacb43c4');

    if (response.statusCode == 200) {
      final List<Midia> midias = [];

      final body = jsonDecode(response.body);
      //debugPrint(body['results'].toString());

      body['results'].map((item) {
        final Midia midia = Midia.fromMap(item);
        //debugPrint(midia.toString());
        midias.add(midia);
      }).toString();

      return midias;
    } else {
      throw Exception('Erro ao carregar midias');
    }
  }

  @override
  getSeries() async {
    final response = await client.get(
        url:
            'https://api.themoviedb.org/3/discover/tv?language=pt-BR&api_key=f5584caeecdbc0937682e809bacb43c4');

    if (response.statusCode == 200) {
      final List<Midia> midias = [];

      final body = jsonDecode(response.body);
      //debugPrint(body['results'].toString());

      body['results'].map((item) {
        final Midia midia = Midia.fromMap(item);
        //debugPrint(midia.toString());
        midias.add(midia);
      }).toString();

      return midias;
    } else {
      throw Exception('Erro ao carregar midias');
    }
  }

  @override
  Future getMidiabyId() async {}

  @override
  getMovies() async {
    final response = await client.get(
        url:
            'https://api.themoviedb.org/3/discover/movie?&language=pt-BR&page=1&sort_by=popularity.desc&api_key=f5584caeecdbc0937682e809bacb43c4');

    if (response.statusCode == 200) {
      final List<Midia> midias = [];

      final body = jsonDecode(response.body);
      //debugPrint(body['results'].toString());

      body['results'].map((item) {
        final Midia midia = Midia.fromMap(item);
        //debugPrint(midia.toString());
        midias.add(midia);
      }).toString();

      return midias;
    } else {
      throw Exception('Erro ao carregar midias');
    }
  }
}
