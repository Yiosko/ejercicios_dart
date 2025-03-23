import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MyApp()); // ejecuta la app
}

class MyApp extends StatelessWidget { //el widget principal, la configuracion de la app y el estado

  const MyApp({super.key}); // este es el constructor de la clase

  @override
  Widget build(BuildContext context) { // el build cada que cambie el estado de la app se va a ejecutar
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'ejercicio_dart',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)
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

  var favorites = <WordPair>[]; // una lista vacia, wordpair es una clase que se encarga de manejar pares de palabras

  void toggleFavorite(){ // metodo que se encarga de agregar o quitar un elemento de la lista de favoritos
    if (favorites.contains(current)){
      favorites.remove(current);
    }else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    var appState = context.watch<MyAppState>(); // realiza el seguimiento del estado de la app
    var pair = appState.current;

    IconData icon; // es el icono que se va a mostrar en el boton de favoritos
    if (appState.favorites.contains(pair)){ // si la lista de favoritos contiene el par de palabras entonces el icono es un corazon lleno
      icon = Icons.favorite;
    } else {
      icon= Icons.favorite_border;
    }



    return Scaffold ( // es widget de nivel superior que implementa el diseño visual de la app
      body: Center(
        child: Column( // toma un solo hijo y lo coloca en una columna es una forma de organizacion
          mainAxisAlignment: MainAxisAlignment.center, // es la alineacion vertical
          children: [
            Text('Hola mundo:'), //texto
            BigCard(pair: pair), //texto en minusculas
            SizedBox(height: 10), // es un espacio en blanco
            Row( // es un widget que coloca a sus hijos en una fila
              mainAxisSize: MainAxisSize.min, // es el tamaño de la fila
              children: [
                ElevatedButton.icon(
                  onPressed: (){
                    appState.toggleFavorite();
                  },
                  icon: Icon(icon),
                  label: Text('Like'), //texto del boton
                ),
                SizedBox(width: 10), // es un espacio en blanco
                ElevatedButton( //boton
                  onPressed: () {
                    appState.getNext(); // ejecuta la funcion getNext del widget MyAppState
                  },
                  child: Text('Next'), //texto del boton
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 

    final style = theme.textTheme.displayMedium!.copyWith( // es el estilo del texto
      color: theme.colorScheme.onPrimary, // es el color del texto
    );

    return Card(
      color: theme.colorScheme.primary, // es el color de fondo del widget background

      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asLowerCase, 
          style: style, 
          semanticsLabel: "${pair.first} ${pair.second}", // es el texto que se va a leer en caso de que el usuario tenga activado el lector de pantalla
          ),
      ),
    );
  }
}