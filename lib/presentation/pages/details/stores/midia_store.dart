import 'package:flutter/material.dart';
import 'package:globoplay_mobile/data/http/exceptions.dart';
import 'package:globoplay_mobile/data/repositories/midia_repository.dart';
import 'package:globoplay_mobile/domain/models/midia.dart';

class MidiaStore {
  final IMidiaRepository repository;

  // Variavel reativa para o loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // Variavel reativa para o state
  final ValueNotifier<Midia> midia = ValueNotifier<Midia>(Midia());

  // variavel para elenco
  final ValueNotifier<List<String>> cast = ValueNotifier<List<String>>([]);

  // recomendacoes
  final ValueNotifier<List<Midia>> recomendacoes =
      ValueNotifier<List<Midia>>([]);

  // Variavel reativa para o erro
  final ValueNotifier<String> error = ValueNotifier<String>('');

  MidiaStore({required this.repository});

  getMidia(int id) async {
    isLoading.value = true;

    try {
      final result = await repository.getMidiabyId(id);
      midia.value = result;
    } on NotFoundException catch (e) {
      debugPrint('aqui 1' + e.toString());
      error.value = e.message;
    } catch (e) {
      debugPrint('aqui 2' + e.toString());
      error.value = 'Erro ao carregar midias';
    }

    isLoading.value = false;
  }

  getCast(int id) async {
    isLoading.value = true;

    try {
      final result = await repository.getCast(id);
      cast.value = result;
    } on NotFoundException catch (e) {
      debugPrint('aqui 1' + e.toString());
      error.value = e.message;
    } catch (e) {
      debugPrint('aqui 2' + e.toString());
      error.value = 'Erro ao carregar midias';
    }

    isLoading.value = false;
  }

  getRecomendacoes(int id) async {
    try {
      final result = await repository.getRecomendacoes(id);
      recomendacoes.value = result;
    } on NotFoundException catch (e) {
      debugPrint('aqui 1' + e.toString());
      error.value = e.message;
    } catch (e) {
      debugPrint('aqui 2' + e.toString());
      error.value = 'Erro ao carregar midias';
    }
  }
}
