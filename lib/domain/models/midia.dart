//import 'package:flutter/material.dart';

class Midia {
  late int id;
  late String name;
  late String genre;
  late String overview;
  late String year;
  late String country;
  late String director;
  late String cast;
  late String availableUntil;
  late String posterPath;
  late String backdropPath;

  //final urlImage = 'https://image.tmdb.org/t/p/original/[poster_path]';

  Midia({
    required this.id,
    required this.name,
    required this.genre,
    required this.overview,
    required this.year,
    required this.country,
    required this.director,
    required this.cast,
    this.availableUntil = '25/06/2024', //date random
    required this.posterPath,
    required this.backdropPath,
  });

  factory Midia.fromMap(Map<String, dynamic> map) {
    return Midia(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      genre: map['genre'] ?? '',
      overview: map['overview'] ?? '',
      year: map['year'] ?? '',
      country: map['country'] ?? '',
      director: map['director'] ?? '',
      cast: map['cast'] ?? '',
      posterPath: map['poster_path'] ?? '',
      backdropPath: map['backdrop_path'] ?? '',
    );
  }
}
