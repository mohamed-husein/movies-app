import 'package:equatable/equatable.dart';

import 'genres_model.dart';

class MoviesDetails extends Equatable {
  final int? id;
  final String? backdropPath;
  final String? poster;
  final String? overView;
  final String? releaseData;
  final int? runtime;
  final String? title;
  final double? voteAverage;
  final List<Genres>? genres;

  const MoviesDetails( [
     this.id,
     this.poster,
     this.backdropPath,
     this.overView,
     this.releaseData,
     this.runtime,
     this.title,
     this.voteAverage,
     this.genres,]
  );

  factory MoviesDetails.fromJson(Map<String, dynamic> json) {
    return MoviesDetails(
      json['id'],
    json['poster_path'],
     json['backdrop_path'],
      
     json['overview'],
      json['release_date'],
     json['runtime'],
     json['title'],
    json['vote_average'].toDouble(),
     List<Genres>.from(
        json['genres'].map(
          (e) => Genres.fromJson(e),
        ),
      ), 
    );
  }

  @override
  List<Object?> get props => [
        id,
        backdropPath,
        overView,
        releaseData,
        runtime,
        title,
        voteAverage,

      ];
}
