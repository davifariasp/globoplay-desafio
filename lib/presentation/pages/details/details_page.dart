import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final int id;
  const DetailsPage({required this.id, super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes'),
        ),
        body: Center(
          child: Text(widget.id.toString()),
        ));
  }
}
