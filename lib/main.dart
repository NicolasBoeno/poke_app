import 'package:flutter/material.dart';
import 'pages/page2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const MyHomePage(title: "Pokemons"),
        "/Page2": (context) => const Page2(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController controllerTextField = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    controllerTextField.dispose();
    super.dispose();
  }

  void _navigateToSecondPage(BuildContext context) {
    final String pokemonName = controllerTextField.text;

    setState(() {
      if (pokemonName.isEmpty) {
        _errorText = 'Por favor, Digite o nome do pokemon';
      } else {
        _errorText = null;
        Navigator.pushNamed(context, '/Page2', arguments: pokemonName);
      }
    });
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
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 300,
                child: TextField(
                  controller: controllerTextField,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 124, 4, 0)),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 124, 4, 0)),
                    ),
                    labelText: "Digite o Nome ou ID do pokemon",
                    labelStyle: _errorText == null
                        ? const TextStyle(color: Colors.blue)
                        : const TextStyle(
                            color: Color.fromARGB(255, 124, 4, 0)),
                    errorText: _errorText,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => {_navigateToSecondPage(context)},
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(150, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  backgroundColor: const Color.fromARGB(255, 0, 92, 167),
                  foregroundColor: const Color.fromARGB(255, 218, 218, 218),
                  shadowColor: const Color.fromARGB(255, 24, 151, 255),
                ),
                child: const Text('Procurar'),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 25,
        alignment: Alignment.bottomRight,
        child: const Text(
          '© Nicolas ~ 07/2024',
        ),
      ),
    );
  }
}
