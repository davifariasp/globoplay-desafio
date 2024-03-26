import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:globoplay_mobile/data/http/http_client.dart';
import 'package:globoplay_mobile/data/repositories/midia_repository.dart';
import 'package:globoplay_mobile/presentation/pages/home/stores/movie_store.dart';
import 'package:globoplay_mobile/presentation/pages/home/stores/novela_store.dart';
import 'package:globoplay_mobile/presentation/pages/home/stores/serie_store.dart';
import 'package:globoplay_mobile/presentation/widgets/list_midia.dart';
import 'package:globoplay_mobile/utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    //pegando as medidas dos dispositovs
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        toolbarHeight: 80,
        title: SvgPicture.asset(
          'lib/assets/globoplay-logo.svg',
          colorFilter: const ColorFilter.mode(
            white,
            BlendMode.srcIn,
          ),
          width: 200,
        ),
      ),
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
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        backgroundColor: black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Minha lista',
          ),
        ],
        selectedItemColor: white,
        unselectedItemColor: greyIcon,
      ),
    );
  }
}
