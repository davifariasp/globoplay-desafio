import 'package:flutter/material.dart';
import 'package:globoplay_mobile/data/http/exceptions.dart';
import 'package:globoplay_mobile/data/repositories/midia_repository.dart';

class SerieStore {
  final IMidiaRepository repository;

  // Variavel reativa para o loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // Variavel reativa para o state
  final ValueNotifier<List> list = ValueNotifier<List>([]);

  // Variavel reativa para o erro
  final ValueNotifier<String> error = ValueNotifier<String>('');

  SerieStore({required this.repository});

  getSeries() async {
    isLoading.value = true;

    try {
      final result = await repository.getSeries();
      list.value = result;
    } on NotFoundException catch (e) {
      debugPrint('aqui 1' + e.toString());
      error.value = e.message;
    } catch (e) {
      debugPrint('aqui 2' + e.toString());
      error.value = 'Erro ao carregar midias';
    }

    isLoading.value = false;
  }
}
