import 'package:flutter/material.dart';
import 'package:globoplay_mobile/data/http/exceptions.dart';
import 'package:globoplay_mobile/data/repositories/midia_repository.dart';

class MidiaStore {
  final IMidiaRepository repository;

  // Variavel reativa para o loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // Variavel reativa para o state
  final ValueNotifier<List> state = ValueNotifier<List>([]);

  // Variavel reativa para o erro
  final ValueNotifier<String> error = ValueNotifier<String>('');

  MidiaStore({required this.repository});

  // Função para carregar as midias
  getMidias() async {
    isLoading.value = true;

    try {
      final result = await repository.getMidias();
      state.value = result;

    }on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = 'Erro ao carregar midias';
    } finally {
      isLoading.value = false;
    }
  }
}
