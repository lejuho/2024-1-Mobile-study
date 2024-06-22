import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'services/pokemon_api.dart';
import 'models/model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PokemonService _pokemonService;
  Future<Model>? _pokemonFuture;
  final TextEditingController _controller = TextEditingController();
  List<String> _pokemonNames = [];
  List<String> _filteredNames = [];

  @override
  void initState() {
    super.initState();
    final dio = Dio();
    _pokemonService = PokemonService(dio);
    _fetchPokemonNames();
  }

  Future<void> _fetchPokemonNames() async {
    // 포켓몬 이름 목록을 가져오는 함수
    final response =
        await Dio().get('https://pokeapi.co/api/v2/pokemon?limit=1000');
    final results = response.data['results'] as List;
    setState(() {
      _pokemonNames =
          results.map((pokemon) => pokemon['name'] as String).toList();
    });
  }

  void _searchPokemon(String name) {
    setState(() {
      _pokemonFuture = _pokemonService.getNamePokemon(name);
    });
  }

  void _reset() {
    setState(() {
      _pokemonFuture = null;
      _controller.clear();
      _filteredNames = [];
    });
  }

  void _filterPokemonNames(String query) {
    setState(() {
      _filteredNames = _pokemonNames
          .where((name) => name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: _reset,
                child: Image.network(
                  'https://raw.githubusercontent.com/PokeAPI/media/master/logo/pokeapi_256.png',
                  height: 100,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '검색할 포켓몬의 이름을 입력해주세요',
                    ),
                    onChanged: _filterPokemonNames,
                    onSubmitted: _searchPokemon,
                  ),
                  if (_filteredNames.isNotEmpty)
                    DropdownButton<String>(
                      items: _filteredNames.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        if (value != null) {
                          _controller.text = value;
                          _searchPokemon(value);
                        }
                      },
                    ),
                ],
              ),
            ),
            if (_pokemonFuture != null)
              FutureBuilder<Model>(
                future: _pokemonFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return Text('No data found');
                  } else {
                    final pokemon = snapshot.data!;
                    return Column(
                      children: <Widget>[
                        Text('Pokemon ID: ${pokemon.id}'),
                        Text('Pokemon Name: ${pokemon.name}'),
                      ],
                    );
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
