import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'This is a title',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
          useMaterial3: true,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  var favorites = [];

  void addPairToFavorites(WordPair addedPair) {
    if (favorites.contains(addedPair)) {
      favorites.remove(addedPair);
    } else {
      favorites.add(addedPair);
    }
    notifyListeners();
  }

  void getRandomPair() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyCard extends StatelessWidget {
  final WordPair pair;

  const MyCard({
    super.key,
    required this.pair,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!
        .copyWith(color: theme.colorScheme.onPrimary);

    return Card(
      color: theme.colorScheme.primary,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              pair.asPascalCase,
              style: style,
              semanticsLabel: "${pair.first} ${pair.second}",
            ),
          ),
        ],
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final pair = appState.current;
    final favorites = appState.favorites;

    IconData icon;

    if (favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
              padding: EdgeInsets.all(
                20,
              ),
              child: Text(
                  "This is my first app ever using flutter after using React Native")),
          MyCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton.icon(
                    icon: Icon(icon),
                    onPressed: () {
                      appState.addPairToFavorites(pair);
                    },
                    label: Text("Like it!")),
              ),
              ElevatedButton(
                  onPressed: () {
                    appState.getRandomPair();
                  },
                  child: Text("Next")),
            ],
          ),
          SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                favorites.first.asCamelCase,
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontFamily: FontStyle.italic.name,
                    fontSize: 19,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
