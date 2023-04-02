import 'package:equatable/equatable.dart';

class Movies extends Equatable {
  final int id;
  final String title;
  final String? backdropPath;
  final List<int> genreIds;
  final String overview;
  final String? releaseDate;
  final double voteAverage;
  final String? posterPath;

  const Movies(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.backdropPath,
      required this.genreIds,
      required this.overview,
      required this.voteAverage,
      required this.releaseDate});

  factory Movies.fromJson(Map<String, dynamic> json) {
    return Movies(
      id: json['id'],
      title: json['title'] ?? 'No Name Found',
      backdropPath: json['backdrop_path'] ?? json['poster_path'] ?? '',
      genreIds: List<int>.from(json['genre_ids'].map((e) => e)),
      overview: json['overview'],
      voteAverage: json['vote_average'].toDouble(),
      releaseDate: json['release_date'] ?? 'Unkown',
      posterPath: json['poster_path'] ?? json['backdrop_path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'overview': overview,
      'vote_average': voteAverage,
      'release_date': releaseDate,
      'poster_path': posterPath
    };
  }

  @override
  List<Object?> get props => [
        id,
        backdropPath,
        overview,
        releaseDate,
        genreIds,
        title,
        voteAverage,
        posterPath,
      ];
}
