import 'package:flutter/material.dart';
import 'package:globoplay_mobile/presentation/pages/details/details_page.dart';

class CardMidia extends StatelessWidget {
  final int id;
  final String poster;
  const CardMidia({required this.id, required this.poster, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DetailsPage(id: id)));
        },
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Image.network(
            'https://image.tmdb.org/t/p/original/$poster',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
