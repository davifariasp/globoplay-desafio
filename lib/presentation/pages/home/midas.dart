import 'package:flutter/material.dart';

import 'package:globoplay_mobile/data/datasources/remote/http/http_client.dart';
import 'package:globoplay_mobile/data/datasources/remote/repositories/midia_repository.dart';
import 'package:globoplay_mobile/presentation/pages/home/stores/movie_store.dart';
import 'package:globoplay_mobile/presentation/pages/home/stores/novela_store.dart';
import 'package:globoplay_mobile/presentation/pages/home/stores/serie_store.dart';
import 'package:globoplay_mobile/presentation/widgets/list_midia.dart';
import 'package:globoplay_mobile/utils.dart';

class MidiasPage extends StatefulWidget {
  const MidiasPage({super.key});

  @override
  State<MidiasPage> createState() => _MidiasPageState();
}

class _MidiasPageState extends State<MidiasPage> {
  final NovelaStore novelaStore = NovelaStore(
    repository: MidiaRepository(
      client: HttpClient(),
    ),
  );

  final SerieStore serieStore = SerieStore(
    repository: MidiaRepository(
      client: HttpClient(),
    ),
  );

  final MovieStore movieStore = MovieStore(
    repository: MidiaRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    novelaStore.getNovelas();
    serieStore.getSeries();
    movieStore.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        decoration: const BoxDecoration(
          color: grey,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListMidia(title: 'Novelas', midiaStore: novelaStore),
              ListMidia(title: 'Séries', midiaStore: serieStore),
              ListMidia(title: 'Filmes', midiaStore: movieStore),
            ],
          ),
        ),
      ),
      
    );
  }
}