import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:globoplay_mobile/app.dart';
import 'package:globoplay_mobile/data/datasources/local/repositories/mylist_repository.dart';
import 'package:provider/provider.dart';

Future main() async {
  await dotenv.load(fileName: "lib/assets/.env");

  runApp(
    ChangeNotifierProvider(
      create: (context) => MyListRepository(),
      child: const MyApp(),
    ),
  );
}
