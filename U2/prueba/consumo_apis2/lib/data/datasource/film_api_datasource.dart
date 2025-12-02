import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/film_model.dart';

class FilmApiDataSource {
  final String baseUrl = 'https://ghibliapi.vercel.app';

  Future<List<FilmModel>> getFilms() async {
    final response = await http.get(Uri.parse('$baseUrl/films'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => FilmModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar películas: ${response.statusCode}');
    }
  }

  Future<FilmModel> getFilmById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/films/$id'));

    if (response.statusCode == 200) {
      return FilmModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al cargar película: ${response.statusCode}');
    }
  }
}
