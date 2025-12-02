import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/film_model.dart';

class FilmsApiDataSource {
  final String baseUrl = 'https://ghibliapi.vercel.app/films';

  /// Obtiene todas las películas de Studio Ghibli
  Future<List<FilmModel>> fetchFilms() async {
    try {
      final uri = Uri.parse(baseUrl);
      final response = await http.get(uri);
      
      if (response.statusCode != 200) {
        throw Exception('Error fetching films: ${response.statusCode}');
      }
      
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => FilmModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Error fetching films: $e');
    }
  }

  /// Obtiene una película específica por ID
  Future<FilmModel> fetchFilmById(String id) async {
    try {
      final uri = Uri.parse('$baseUrl/$id');
      final response = await http.get(uri);
      
      if (response.statusCode != 200) {
        throw Exception('Error fetching film $id: ${response.statusCode}');
      }
      
      final Map<String, dynamic> data = json.decode(response.body);
      return FilmModel.fromJson(data);
    } catch (e) {
      throw Exception('Error fetching film: $e');
    }
  }

  /// Obtiene películas con paginación (simulada en el cliente)
  Future<List<FilmModel>> fetchFilmsPaginated({
    int limit = 10,
    int offset = 0,
  }) async {
    try {
      final allFilms = await fetchFilms();
      
      // Paginación en el cliente
      if (offset >= allFilms.length) {
        return [];
      }
      
      final endIndex = (offset + limit > allFilms.length) 
          ? allFilms.length 
          : offset + limit;
      
      return allFilms.sublist(offset, endIndex);
    } catch (e) {
      throw Exception('Error fetching paginated films: $e');
    }
  }

  /// Filtra películas por director
  Future<List<FilmModel>> filterByDirector(String director) async {
    try {
      final allFilms = await fetchFilms();
      return allFilms
          .where((film) => film.director.toLowerCase().contains(director.toLowerCase()))
          .toList();
    } catch (e) {
      throw Exception('Error filtering films by director: $e');
    }
  }

  /// Filtra películas por año
  Future<List<FilmModel>> filterByYear(String year) async {
    try {
      final allFilms = await fetchFilms();
      return allFilms
          .where((film) => film.releaseDate.contains(year))
          .toList();
    } catch (e) {
      throw Exception('Error filtering films by year: $e');
    }
  }
}
