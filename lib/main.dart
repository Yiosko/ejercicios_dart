import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(Myapp()); // ejecuta la app
}

class Myapp extends StatelessWidget { //el widget principal, la configuracion de la app y el estado

  const Myapp({super.key}); // este es el constructor de la clase

  @override
  Widget build(BuildContext context) { // el build cada que cambie el estado de la app se va a ejecutar
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

class MyAppState extends ChangeNotifier { //este widget es el que se encarga de manejar el estado de la app y de notificar a los widgets hijos cuando cambia el estado
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random(); // reasigna el valor de current a una nueva palabra
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    var appState = context.watch<MyAppState>(); // realiza el seguimiento del estado de la app

    return Scaffold ( // es widget de nivel superior que implementa el diseño visual de la app
      body: Column( // toma un solo hijo y lo coloca en una columna es una forma de organizacion
        children: [
          Text('Hola mundo:'), //texto
          Text(appState.current.asLowerCase), //texto en minusculas

          ElevatedButton( //boton
            onPressed: () {
              appState.getNext(); // ejecuta la funcion getNext del widget MyAppState
            },
            child: Text('Next'), //texto del boton
          ),
        ],
      ),
    );
  }
}