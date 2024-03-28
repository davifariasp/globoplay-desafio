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

  verify(Midia midia) {
    return (myList.any((element) => element.id == midia.id)) ? true : false;
  }

  remove(Midia midia) {
    myList.removeWhere((element) => element.id == midia.id);
    notifyListeners();
  }

  List<Midia> getAll() {
    return myList;
  }
}
