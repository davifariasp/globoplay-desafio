import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:globoplay_mobile/data/datasources/remote/http/http_client.dart';
import 'package:globoplay_mobile/domain/models/midia.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final baseUrl = dotenv.env['BASE_URL'];
final apiKey = dotenv.env['API_KEY'];

abstract class IMidiaRepository {
  getNovelas();
  getSeries();
  getMovies();
  getMidiabyId(int id); //more details
  getCast(int id);
  getRecomendacoes(int id);
}

class MidiaRepository implements IMidiaRepository {
  final IHttpClient client;

  MidiaRepository({required this.client});

  @override
  Future getNovelas() async {
    final response = await client.get(
        url:
            '$baseUrl/discover/tv?language=pt-BR&with_networks=3290&api_key=$apiKey');

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
            '$baseUrl/discover/tv?language=pt-BR&api_key=$apiKey');

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
  getMidiabyId(int id) async {
    final response = await client.get(
        url:
            '$baseUrl/tv/$id?language=pt-BR&api_key=$apiKey');

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final Midia midia = Midia.fromMap(body);
      return midia;
    } else if (response.statusCode == 404) {
      final newResponse = await client.get(
          url:
              '$baseUrl/movie/$id?language=pt-BR&api_key=$apiKey');

      final body = jsonDecode(newResponse.body);
      final Midia midia = Midia.fromMap(body);
      return midia;
    } else {
      throw Exception('Erro ao carregar midia');
    }
  }

  @override
  getMovies() async {
    final response = await client.get(
        url:
            '$baseUrl/discover/movie?&language=pt-BR&page=1&sort_by=popularity.desc&api_key=$apiKey');

    if (response.statusCode == 200) {
      final List<Midia> midias = [];

      final body = jsonDecode(response.body);
      //debugPrint(body['results'].toString());

      body['results'].map((item) {
        final Midia midia = Midia.fromMap(item);
        debugPrint(midia.toString());
        midias.add(midia);
      }).toString();

      return midias;
    } else {
      throw Exception('Erro ao carregar filmes');
    }
  }

  @override
  getCast(int id) async {
    final response = await client.get(
        url:
            '$baseUrl/tv/$id/aggregate_credits?language=pt-br&api_key=$apiKey');

    if (response.statusCode == 200) {
      List<String> cast = [];

      final body = jsonDecode(response.body);

      body['cast'].map((item) {
        cast.add(item['name']);
      }).toString();

      return cast;
    } else {
      throw Exception('Erro ao carregar casting');
    }
  }

  @override
  getRecomendacoes(int id) async {
    final response = await client.get(
        url:
            '$baseUrl/tv/$id/recommendations?language=pt-BR&api_key=$apiKey');

    if (response.statusCode == 200) {
      List<Midia> midias = [];

      final body = jsonDecode(response.body);
      //debugPrint(body['results'].toString());

      body['results'].map((item) {
        final Midia midia = Midia.fromMap(item);
        //debugPrint(midia.toString());
        midias.add(midia);
      }).toString();

      return midias;
    } else if (response.statusCode == 404) {
      final newResponse = await client.get(
          url:
              '$baseUrl/movie/$id/recommendations?language=pt-BR&api_key=$apiKey');

      List<Midia> midias = [];

      final body = jsonDecode(newResponse.body);
      body['results'].map((item) {
        final Midia midia = Midia.fromMap(item);
        //debugPrint(midia.toString());
        midias.add(midia);
      }).toString();

      return midias;
    } else {
      throw Exception('Erro ao carregar recomendacoes');
    }
  }
}
