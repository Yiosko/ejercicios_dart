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
/*
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
*/

class MyHomePage extends StatefulWidget { // es un widget que puede cambiar su estado interno durante la ejecucion
  @override
  State<MyHomePage> createState() => _MyHomePageState(); // es el estado inicial del widget 
}

class _MyHomePageState extends State<MyHomePage> { // este widget es el que se encarga de manejar el estado de la app y de notificar a los widgets hijos cuando cambiar el estado
  @override
  Widget build(BuildContext context){ // el build cada que cambie el estado de la app se va a ejecutar
    return Scaffold( // es widget de nivel superior que implementa el diseño visual de la app
      body: Row ( // es un widget que coloca a sus hijos en una fila
        children: [
          SafeArea( // es un widget que se encarga de colocar a sus hijos en un area segura
            child: NavigationRail( // es un widget que se encarga de mostrar una barra de navegacion
              extended: false, // es si la barra de navegacion esta extendida
              destinations:[
                NavigationRailDestination( // es un item de la barra de navegacion
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text('Favorites'),
                ),
              ],
              selectedIndex: 0, // es el indice del item seleccionado
              onDestinationSelected: (value) { // es la funcion que se ejecuta cuando se selecciona un item
                print('selected $value'); 
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer, // es el color de fondo del widget background
              child: GeneratorPage(), // es el widget que se va a mostrar
            )
          )
        ],
      ),
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    var appState = context.watch<MyAppState>(); // realiza el seguimiento del estado de la app
    var pair = appState.current;

    IconData icon;
    if(appState.favorites.contains(pair)){ // si la lista de favoritos contiene el par de palabras entonces el icono es un corazon lleno
      icon = Icons.favorite; // icono de corazon lleno
    } else {
      icon = Icons.favorite_border; // icono de corazon vacio
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // es la alineacion vertical
        children: [
          BigCard(pair: pair), //texto en minusculas
          SizedBox(height: 10), // es un espacio en blanco
          Row(
            mainAxisSize: MainAxisSize.min, // es el tamaño de la fila
            children: [
              ElevatedButton.icon( // boton con icono
                onPressed: (){
                  appState.toggleFavorite(); // ejecuta la funcion toggleFavorite del widget MyAppState
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton (
                onPressed: (){
                  appState.getNext(); // ejecuta la funcion getNext del widget MyAppState
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
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