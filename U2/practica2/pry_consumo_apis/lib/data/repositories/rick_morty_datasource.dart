import 'dart:convert'; // de objeto a JSON
import 'package:http/http.dart' as http;
import '../datasources/base_datasource.dart';
import '../models/character_model.dart';


class RickMortyDatasource extends BaseDatasource<CharacterModel> {
  final String _url = 'https://rickandmortyapi.com/api/character';
  
  // hacer get peticion
  Future<List<CharacterModel>> fetchData()async {
    
  final resp = await http.get(Uri.parse(_url));
 
  //validadcion 
  if(resp.statusCode != 200){
    throw Exception('Failed to load data from API');
  }  
    final data = json.decode(resp.body);
    
      //list 
    final List results = data['results'];


  return results.map((json) => CharacterModel.fromJson(json)).toList();
  //json se hace objeto 

  }
}



