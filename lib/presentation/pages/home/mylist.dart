import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:globoplay_mobile/data/datasources/local/repositories/mylist_repository.dart';
import 'package:globoplay_mobile/domain/models/midia.dart';
import 'package:globoplay_mobile/presentation/widgets/card_midia.dart';
import 'package:globoplay_mobile/utils.dart';
import 'package:provider/provider.dart';

class MyListPage extends StatefulWidget {
  const MyListPage({super.key});

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  late MyListRepository myListRepository;

  @override
  Widget build(BuildContext context) {
    myListRepository = Provider.of<MyListRepository>(context);

    List<Midia> list = myListRepository.getAll();

    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          color: grey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 350,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => CardMidia(
                  id: list[index].id!,
                  poster: list[index].posterPath!,
                ),
                itemCount: list.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
