import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:globoplay_mobile/data/http/http_client.dart';
import 'package:globoplay_mobile/data/repositories/midia_repository.dart';
import 'package:globoplay_mobile/presentation/pages/details/stores/midia_store.dart';
import 'package:globoplay_mobile/utils.dart';

class DetailsPage extends StatefulWidget {
  final int id;
  const DetailsPage({required this.id, super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final MidiaStore midiaStore = MidiaStore(
    repository: MidiaRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    midiaStore.getMidia(widget.id);
  }

  @override
  Widget build(BuildContext context) {
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
          } else if (midiaStore.midia.value != null) {
            return Container(
                height: size.height,
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 80,
                          ),
                          SizedBox(
                            width: 180,
                            child: Image.network(
                              '$urlImgAPI${midiaStore.midia.value.posterPath}',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
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
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  backgroundColor: MaterialStateProperty.all(
                                    white,
                                  ),
                                  foregroundColor: MaterialStateProperty.all(
                                    grey,
                                  ),
                                  fixedSize: MaterialStateProperty.all(
                                    const Size(180, 50),
                                  ),
                                  overlayColor: MaterialStateProperty.all(
                                    greyBt,
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.star),
                                label: const Text(
                                  'Minha lista',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(
                                    greyIcon,
                                  ),
                                  fixedSize: MaterialStateProperty.all(
                                    const Size(180, 50),
                                  ),
                                  overlayColor: MaterialStateProperty.all(
                                    white,
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      side: const BorderSide(color: greyIcon),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ));
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
