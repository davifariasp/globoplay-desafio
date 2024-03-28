import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:globoplay_mobile/data/datasources/local/repositories/mylist_repository.dart';
import 'package:globoplay_mobile/data/datasources/remote/http/http_client.dart';
import 'package:globoplay_mobile/data/datasources/remote/repositories/midia_repository.dart';
import 'package:globoplay_mobile/domain/models/midia.dart';
import 'package:globoplay_mobile/presentation/pages/details/stores/midia_store.dart';
import 'package:globoplay_mobile/presentation/widgets/card_midia.dart';
import 'package:globoplay_mobile/utils.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final int id;
  const DetailsPage({required this.id, super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with TickerProviderStateMixin {
  List<String> cast = [];
  List<Midia> recomendacoes = [];
  late MyListRepository myListRepository;

  final MidiaStore midiaStore = MidiaStore(
    repository: MidiaRepository(
      client: HttpClient(),
    ),
  );

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    midiaStore.getMidia(widget.id);
    getCast();
    getRecomendacoes();
  }

  //casting
  getCast() async {
    await midiaStore.getCast(widget.id);

    setState(() {
      cast = midiaStore.cast.value;
    });
  }

  //recomendacoes
  getRecomendacoes() async {
    await midiaStore.getRecomendacoes(widget.id);

    setState(() {
      recomendacoes = midiaStore.recomendacoes.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    myListRepository = Provider.of<MyListRepository>(context);

    bool midiaOnMyList = myListRepository.verify(midiaStore.midia.value);

    var size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: white,
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge(
          [
            midiaStore.isLoading,
            midiaStore.error,
            midiaStore.midia,
          ],
        ),
        builder: (context, child) {
          if (midiaStore.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
            // ignore: unnecessary_null_comparison
          } else if (midiaStore.midia.value != null) {
            return SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            '$urlImgAPI${midiaStore.midia.value.backdropPath}',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black,
                                  Colors.black.withOpacity(0.3)
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 80,
                                  ),
                                  SizedBox(
                                    width: 140,
                                    child: Image.network(
                                      '$urlImgAPI${midiaStore.midia.value.posterPath}',
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.error),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    midiaStore.midia.value.name ?? '',
                                    style: const TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    midiaStore.midia.value.overview ?? '',
                                    style: const TextStyle(
                                      color: white,
                                      fontSize: 18,
                                    ),
                                    maxLines: 4,
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton.icon(
                                        onPressed: () {},
                                        icon: const Icon(Icons.play_arrow),
                                        label: const Text(
                                          'Assistir',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                            const EdgeInsets.all(0),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            white,
                                          ),
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                            grey,
                                          ),
                                          fixedSize: MaterialStateProperty.all(
                                            const Size(170, 50),
                                          ),
                                          overlayColor:
                                              MaterialStateProperty.all(
                                            greyBt,
                                          ),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                      ),
                                      midiaOnMyList
                                          ? TextButton.icon(
                                              onPressed: () {
                                                myListRepository.remove(
                                                    midiaStore.midia.value);
                                              },
                                              icon: const Icon(Icons.check),
                                              label: const Text(
                                                'Adicionado',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              style: ButtonStyle(
                                                padding:
                                                    MaterialStateProperty.all(
                                                  const EdgeInsets.all(0),
                                                ),
                                                foregroundColor:
                                                    MaterialStateProperty.all(
                                                  greyIcon,
                                                ),
                                                fixedSize:
                                                    MaterialStateProperty.all(
                                                  const Size(170, 50),
                                                ),
                                                overlayColor:
                                                    MaterialStateProperty.all(
                                                  white,
                                                ),
                                                shape:
                                                    MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    side: const BorderSide(
                                                        color: greyIcon),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : TextButton.icon(
                                              onPressed: () {
                                                myListRepository.save(
                                                    midiaStore.midia.value);
                                              },
                                              icon: const Icon(Icons.star),
                                              label: const Text(
                                                'Minha lista',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              style: ButtonStyle(
                                                padding:
                                                    MaterialStateProperty.all(
                                                  const EdgeInsets.all(0),
                                                ),
                                                foregroundColor:
                                                    MaterialStateProperty.all(
                                                  greyIcon,
                                                ),
                                                fixedSize:
                                                    MaterialStateProperty.all(
                                                  const Size(170, 50),
                                                ),
                                                overlayColor:
                                                    MaterialStateProperty.all(
                                                  white,
                                                ),
                                                shape:
                                                    MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    side: const BorderSide(
                                                        color: greyIcon),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: size.width,
                      decoration: const BoxDecoration(
                        color: black,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: TabBar(
                              labelColor: white,
                              unselectedLabelColor: greyIcon,
                              indicatorColor: white,
                              controller: _tabController,
                              dividerColor: Colors.transparent,
                              tabs: const [
                                Tab(
                                  text: 'ASSISTA TAMBÉM',
                                ),
                                Tab(
                                  text: 'DETALHES',
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: grey,
                              ),
                              width: double.maxFinite,
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 25),
                                    child: SizedBox(
                                      height: 250,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) =>
                                            CardMidia(
                                          id: recomendacoes[index].id!,
                                          poster:
                                              recomendacoes[index].posterPath!,
                                        ),
                                        itemCount: recomendacoes.length,
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    padding: const EdgeInsets.only(
                                        top: 20,
                                        right: 15,
                                        bottom: 30,
                                        left: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          'Ficha técnica',
                                          style: TextStyle(
                                              color: white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                              color: greyText,
                                              fontSize: 17,
                                            ),
                                            children: [
                                              const TextSpan(
                                                text: 'Nome original: ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${midiaStore.midia.value.originalName}',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                              color: greyText,
                                              fontSize: 17,
                                            ),
                                            children: [
                                              const TextSpan(
                                                text: 'Genero: ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              midiaStore.midia.value.genres ==
                                                      null
                                                  ? const TextSpan(
                                                      text: 'Sem gênero',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    )
                                                  : TextSpan(
                                                      children: midiaStore
                                                          .midia.value.genres!
                                                          .asMap()
                                                          .entries
                                                          .map((entry) {
                                                        final genre =
                                                            entry.value;
                                                        final isLast = entry
                                                                .key ==
                                                            midiaStore
                                                                    .midia
                                                                    .value
                                                                    .genres!
                                                                    .length -
                                                                1;
                                                        return TextSpan(
                                                          text: isLast
                                                              ? '${genre['name']}'
                                                              : '${genre['name']}, ',
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        );
                                                      }).toList(),
                                                    )
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                              color: greyText,
                                              fontSize: 17,
                                            ),
                                            children: [
                                              const TextSpan(
                                                text: 'Episódios: ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${midiaStore.midia.value.episodes}',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                              color: greyText,
                                              fontSize: 17,
                                            ),
                                            children: [
                                              const TextSpan(
                                                text: 'Ano de produção: ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${midiaStore.midia.value.year}',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                              color: greyText,
                                              fontSize: 17,
                                            ),
                                            children: [
                                              const TextSpan(
                                                text: 'País: ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${midiaStore.midia.value.country}',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                              color: greyText,
                                              fontSize: 17,
                                            ),
                                            children: [
                                              const TextSpan(
                                                text: 'Direção: ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${midiaStore.midia.value.originalName}',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                              color: greyText,
                                              fontSize: 17,
                                            ),
                                            children: [
                                              const TextSpan(
                                                text: 'Elenco: ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text: '${cast.join(', ')}',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                              color: greyText,
                                              fontSize: 17,
                                            ),
                                            children: [
                                              const TextSpan(
                                                text: 'Disponível até: ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${midiaStore.midia.value.availableUntil}',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Center(
              child: Text(
                "Nenhuma midia encontrada!",
                style: TextStyle(color: white),
              ),
            );
          }
        },
      ),
    );
  }
}
