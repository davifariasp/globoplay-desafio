import 'package:flutter/material.dart';
import 'package:globoplay_mobile/app.dart';
import 'package:globoplay_mobile/data/datasources/local/repositories/mylist_repository.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyListRepository(),
      child: const MyApp(),
    ),
  );
}
