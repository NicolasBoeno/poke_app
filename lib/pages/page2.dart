import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  late String pokemonName;
  String nomePokemon = "";
  String imagemPokemon = "";
  String tipoPokemon = "";
  double pesoPokemon = 0;
  Color corFundoCard = Colors.white;
  String errorMessage = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pokemonName = ModalRoute.of(context)!.settings.arguments as String;

    // Buscar Pokémon na API
    _buscaPokemonInfo(pokemonName);
  }

  void _voltarPagina1() {
    Navigator.pop(context);
  }

  Future<void> _buscaPokemonInfo(String name) async {
    final nome = name.toLowerCase();
    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$nome'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        imagemPokemon =
            data['sprites']['other']['official-artwork']['front_default'];
        nomePokemon = data['name'];
        tipoPokemon = data['types'][0]['type']['name'];
        pesoPokemon = double.parse('${data['weight']}') / 10;
        errorMessage = "";

        var corFundo = {
          "fire": const Color.fromARGB(255, 240, 128, 48),
          "water": const Color.fromARGB(255, 104, 144, 240),
          "electric": const Color.fromARGB(255, 248, 208, 48),
          "grass": const Color.fromARGB(255, 120, 200, 80),
          "bug": const Color.fromARGB(255, 168, 184, 32),
          "normal": const Color.fromARGB(255, 168, 168, 120),
          "poison": const Color.fromARGB(255, 160, 64, 160),
          "flying": const Color.fromARGB(255, 168, 144, 240),
          "fighting": const Color.fromARGB(255, 192, 48, 40),
          "ground": const Color.fromARGB(255, 224, 192, 104),
          "fairy": const Color.fromARGB(255, 238, 153, 172),
          "psychic": const Color.fromARGB(255, 248, 88, 136),
          "rock": const Color.fromARGB(255, 184, 160, 56),
          "ghost": const Color.fromARGB(255, 112, 88, 152),
          "ice": const Color.fromARGB(255, 152, 216, 216),
          "dragon": const Color.fromARGB(255, 112, 56, 248),
          "dark": const Color.fromARGB(255, 112, 88, 72),
          "steel": const Color.fromARGB(255, 184, 184, 208),
        };

        corFundoCard = corFundo[tipoPokemon] ?? Colors.white;
      });
    } else {
      setState(() {
        nomePokemon = "";
        imagemPokemon = "";
        tipoPokemon = "";
        errorMessage = "Pokémon não encontrado";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 48, 78),
        elevation: 1,
        shadowColor: Colors.blue,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontFamily: 'PokemonSolid',
        ),
        title: const Text('Info'),
      ),
      body: Center(
        child: imagemPokemon.isEmpty &&
                nomePokemon.isEmpty &&
                errorMessage.isEmpty
            ? const CircularProgressIndicator(
                color: Color.fromARGB(255, 255, 0, 0))
            : errorMessage.isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/snorlax_sleep.png',
                        width: 500,
                        filterQuality: FilterQuality.high,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        errorMessage,
                        style: const TextStyle(
                            fontSize: 25,
                            color: Colors.red,
                            shadows: [
                              BoxShadow(color: Colors.red, blurRadius: 4)
                            ]),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(25),
                          backgroundColor:
                              const Color.fromARGB(255, 0, 92, 167),
                          foregroundColor:
                              const Color.fromARGB(255, 218, 218, 218),
                          shadowColor: const Color.fromARGB(255, 24, 151, 255),
                        ),
                        child: const Icon(Icons.arrow_back),
                        onPressed: () {
                          _voltarPagina1();
                        },
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 100,
                        shadowColor: corFundoCard,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: corFundoCard,
                          ),
                        ),
                        color: corFundoCard,
                        child: Image.network(
                          imagemPokemon,
                          width: 200,
                          height: 200,
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return const Text('Erro ao carregar a imagem');
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Nome do Pokémon: $nomePokemon',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Tipo: $tipoPokemon',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Peso: $pesoPokemon Kg',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                      FloatingActionButton(
                        backgroundColor: const Color.fromARGB(255, 0, 92, 167),
                        child: const Icon(Icons.home_outlined),
                        onPressed: () {
                          _voltarPagina1();
                        },
                      )
                    ],
                  ),
      ),
    );
  }
}
