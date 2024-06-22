import 'package:dio/dio.dart';
import 'package:gdscflutter/models/model.dart';
import 'package:retrofit/retrofit.dart';

part 'pokemon_api.g.dart';

@RestApi(baseUrl: "https://pokeapi.co/api/v2/")
abstract class PokemonService {
  factory PokemonService(Dio dio, {String baseUrl}) = _PokemonService;

  // API1
  @GET('/pokemon/{id}')
  Future<Model> getIdPokemon(
    @Path('id') int id,
  );

  @GET('/pokemon/{name}')
  Future<Model> getNamePokemon(
    @Path('name') String name,
  );
}
