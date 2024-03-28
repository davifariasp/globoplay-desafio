import 'package:flutter/material.dart';
import 'package:globoplay_mobile/presentation/widgets/card_midia.dart';
import 'package:globoplay_mobile/utils.dart';

class ListMidia extends StatefulWidget {
  final String title;
  final dynamic midiaStore;
  const ListMidia({required this.title, required this.midiaStore, super.key});

  @override
  State<ListMidia> createState() => _ListMidiaState();
}

class _ListMidiaState extends State<ListMidia> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(
        [
          widget.midiaStore.isLoading,
          widget.midiaStore.error,
          widget.midiaStore.list,
        ],
      ),
      builder: (context, child) {
        if (widget.midiaStore.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: white,
            ),
          );
        } else if (widget.midiaStore.list.value.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => CardMidia(
                      id: widget.midiaStore.list.value[index].id,
                      poster: widget.midiaStore.list.value[index].posterPath,
                    ),
                    itemCount: widget.midiaStore.list.value.length,
                  ),
                ),
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
    );
  }
}
