import 'package:flutter/material.dart';
import 'package:globoplay_mobile/domain/models/midia.dart';

class MyListRepository extends ChangeNotifier {
  List<Midia> myList = [];

  saveAll(List<Midia> midias) {
    midias.forEach((midia) {
      if (!myList.contains(midia)) myList.add(midia);
    });

    notifyListeners();
  }

  save(Midia midia) {
    debugPrint('midia: ${midia.name}');
    myList.add(midia);
    //getAll();
    notifyListeners();
  }

  remove(Midia midia) {
    myList.remove(midia);
    notifyListeners();
  }

  List<Midia> getAll() {
    return myList;
    // myList.forEach((element) {
    //   debugPrint('element: ${element.name}');
    // });
  }
}
