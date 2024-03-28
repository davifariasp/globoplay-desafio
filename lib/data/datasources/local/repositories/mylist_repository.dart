import 'package:flutter/material.dart';
import 'package:globoplay_mobile/domain/models/midia.dart';

class MyListRepository extends ChangeNotifier {
  List<Midia> myList = [];

  save(Midia midia) {

    //com esse ele nao adiciona iguais
    if (!myList.any((element) => element.id == midia.id)) {
      myList.add(midia);
    }

    notifyListeners();
  }

  remove(Midia midia) {
    myList.remove(midia);
    notifyListeners();
  }

  List<Midia> getAll() {
    return myList;
  }
}
