//import 'package:flutter/material.dart';
class Midia {
  late int? id;
  late String? name;
  late String? originalName;
  late List<dynamic>? genres;
  late int? episodes;
  late String? overview;
  late String? year;
  late String? country;
  late String? availableUntil;
  late String? posterPath;
  late String? backdropPath;

  Midia({
    this.id,
    this.name,
    this.originalName,
    this.genres,
    this.episodes,
    this.overview,
    this.year,
    this.country,
    this.availableUntil = '25/12/2024', //date random
    this.posterPath,
    this.backdropPath,
  });

  factory Midia.fromMap(Map<String, dynamic> map) {
    String country = '';

    //no caso dos filmes eles nao dao o country
    if (map['origin_country'] != null) {
      country = List<String>.from(map['origin_country']).first;
    }

    
    return Midia(
      id: map['id'] ?? '',
      name: (map['name'] == null) ? map['title'] : map['name'],
      originalName: map['original_name'] ?? '',
      genres: map['genres'] ?? [],
      episodes: map['number_of_episodes'] ?? 0,
      overview: map['overview'],
      year: map['first_air_date'].toString().split("-")[0],
      country: country,
      posterPath: map['poster_path'] ?? '',
      backdropPath: map['backdrop_path'] ?? '',
    );
  }
}
