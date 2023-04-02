import 'package:equatable/equatable.dart';

class Favorites extends Equatable {
  final int id;
  final String title;
  final double voteAverage;
  final String backdropPath;
  final String posterPath;
  final bool inFav;

  const Favorites({
    required this.id,
    required this.title,
    required this.backdropPath,
    required this.posterPath,
    required this.voteAverage,
    this.inFav = false,
  });

  factory Favorites.fromJson(Map<String, dynamic> json) {
    return Favorites(
      id: json['id'],
      title: json['title'],
      voteAverage: json['vote_average'],
      backdropPath: json['backdrop_path'],
      posterPath: json['poster_path'],
    );
  }

  Favorites copyWith({
    String? title,
    int? id,
    String? posterPath,
    String? backdropPath,
    bool? inFav,
    double? voteAverage
  }) {
    return Favorites(
      title: title ?? this.title,
      id: id ?? this.id,
      backdropPath: backdropPath ?? this.backdropPath,
      posterPath: posterPath ?? this.posterPath,
      inFav: inFav ?? this.inFav,
      voteAverage: voteAverage??this.voteAverage,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title':title,
      'id':id,
      'poster_path':posterPath,
      'backdrop_path':backdropPath,
      'vote_average':voteAverage,
    };
  }

  @override
  List<Object?> get props => [id, title, backdropPath, posterPath,voteAverage];
}
