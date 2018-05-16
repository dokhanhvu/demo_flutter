import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];

  final _saved = new Set<WordPair>();

  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
            print("length: ${_suggestions.length}");
          }
          print("$i : ${_suggestions[i].toString()}");
          return _buildRow(_suggestions[i]);
        });

//  return new Center(
//    child: new Column(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: <Widget>[
//
//      ],
//    ),
//  );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new Container(
      child: new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              title: new Text(
                pair.asPascalCase,
                style: _biggerFont,
              ),
              trailing: new Icon(
                alreadySaved ? Icons.favorite : Icons.favorite_border,
                color: alreadySaved ? Colors.red : null,
              ),
              onTap: () {
                setState(() {
                  if (alreadySaved) {
                    _saved.remove(pair);
                  } else {
                    _saved.add(pair);
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text('Startup Name Generator'),
//        actions: <Widget>[
//          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
//        ],
//      ),
      body: _buildSuggestions(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _pushSaved,
        tooltip: 'Add',
        child: new Icon(Icons.list),
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map((pair) {
            return new Card(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new ListTile(
                    title: new Text(
                      pair.asPascalCase,
                      style: _biggerFont,
                    ),
                  )
                ],
              ),
            );
          });

          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Saved Suggestions'),
            ),
            body: new ListView(
              padding: const EdgeInsets.all(16.0),
              children: tiles.toList(),
            ),
          );
        },
      ),
    );
  }
}
