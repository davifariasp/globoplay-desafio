import 'dart:convert';

import 'package:globoplay_mobile/data/http/http_client.dart';
import 'package:globoplay_mobile/domain/models/midia.dart';

abstract class IMidiaRepository {
  getMidias();
  getMidiabyId(); //more details
}

class MidiaRepository implements IMidiaRepository {
  final IHttpClient client;

  final baseUrl = const String.fromEnvironment('BASE_URL');
  final apiKey = const String.fromEnvironment('API_KEY');

  late final String globoplayUrl =
      "$baseUrl/discover/tv?language=pt-BR&with_networks=3290&api_key=$apiKey";

  MidiaRepository(this.client);

  @override
  Future getMidias() async {
    final response =
        await client.get(url: '$baseUrl/movie/popular?api_key=$apiKey');

    if (response.statusCode == 200) {
      final List<Midia> midias = [];

      final body = jsonDecode(response.body);

      body['results'].map((item) {
        final Midia midia = Midia.fromMap(item);
        midias.add(midia);
      }).toString();

      return midias;
    } else {
      throw Exception('Erro ao carregar midias');
    }
  }

  @override
  Future getMidiabyId() async {
    client.get(url: '$baseUrl/movie/popular?api_key=$apiKey');
  }
}
