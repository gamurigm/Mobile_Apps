import '../../domain/entities/film_entity.dart';

class FilmModel extends FilmEntity {
  FilmModel({
    required super.id,
    required super.title,
    required super.originalTitle,
    required super.originalTitleRomanised,
    required super.image,
    required super.movieBanner,
    required super.description,
    required super.director,
    required super.producer,
    required super.releaseDate,
    required super.runningTime,
    required super.rtScore,
    required super.people,
    required super.species,
    required super.locations,
    required super.vehicles,
    required super.url,
  });

  factory FilmModel.fromJson(Map<String, dynamic> json) {
    return FilmModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      originalTitle: json['original_title'] ?? '',
      originalTitleRomanised: json['original_title_romanised'] ?? '',
      image: json['image'] ?? '',
      movieBanner: json['movie_banner'] ?? '',
      description: json['description'] ?? '',
      director: json['director'] ?? '',
      producer: json['producer'] ?? '',
      releaseDate: json['release_date'] ?? '',
      runningTime: json['running_time'] ?? '',
      rtScore: json['rt_score'] ?? '',
      people: json['people'] != null ? List<String>.from(json['people']) : [],
      species: json['species'] != null ? List<String>.from(json['species']) : [],
      locations: json['locations'] != null ? List<String>.from(json['locations']) : [],
      vehicles: json['vehicles'] != null ? List<String>.from(json['vehicles']) : [],
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'original_title': originalTitle,
      'original_title_romanised': originalTitleRomanised,
      'image': image,
      'movie_banner': movieBanner,
      'description': description,
      'director': director,
      'producer': producer,
      'release_date': releaseDate,
      'running_time': runningTime,
      'rt_score': rtScore,
      'people': people,
      'species': species,
      'locations': locations,
      'vehicles': vehicles,
      'url': url,
    };
  }
}
