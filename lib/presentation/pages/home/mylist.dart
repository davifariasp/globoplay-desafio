import 'package:flutter/material.dart';
import 'package:globoplay_mobile/utils.dart';

class MyListPage extends StatefulWidget {
  const MyListPage({super.key});

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          color: grey,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [Text('oiii')],
          ),
        ),
      ),
    );
  }
}
