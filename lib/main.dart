import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(Myapp());
} // Run the app

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'ejercicio_dart',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange)
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    var appState = context.watch<MyAppState>();

    return Scaffold (
      body: Column(
        children: [
          Text('Hola mundo:'), //texto
          Text(appState.current.asLowerCase), //texto en minusculas

          ElevatedButton( //boton
            onPressed: () {
              print('Que rico'); //mensaje en consola
            },
            child: Text('Presioname bb'), //texto del boton
          ),
        ],
      ),
    );
  }
}