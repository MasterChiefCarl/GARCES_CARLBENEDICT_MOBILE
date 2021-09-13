import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());
//now lets change the look of the app honestly it looks meh... hahahaha

class MyApp extends StatelessWidget { 
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SNG',
      theme: ThemeData(          // Add the 3 lines from here... 
        primaryColor: Colors.black,
      ),                         // ... to here.
      home: RandomWords(),
    );
  }
}
  /*
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();  // DELETE

    return MaterialApp(
      title: 'welcome', //so it does not work... yet hmmm
      home: Scaffold(
        appBar: AppBar(
          title: RandomWords(),
        ),
        body: Center(
          //child: Text(wordPair.asPascalCase), // REPLACE with... 
          child: RandomWords(),                 // ...this line // calls the randomWords() function loacted at the bottom
        ),
      ),
    );
  }
  */

//With a stateful widget ,we can use the command anywhere we might need it 
//because later on we will be working with different widgets and we might need to transfer the same command in a different widget
//so instead of retyping, make a stateful widget :)




//well it works .. but idk why is this error still existing though :(
//this has been my second take and still same result but at least i can see it working

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> { //indecate privacy 
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};     // NEW                 // NEW
  final _biggerFont = const TextStyle(fontSize: 18); // NEW
 
    @override
        Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Lazy Compounds'),
              actions: [
                IconButton(icon: Icon(Icons.list),onPressed: _pushSaved),
              ],
            ),
            body: _buildSuggestions(),
          );
        }

      Widget _buildSuggestions() {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          // The itemBuilder callback is called once per suggested 
          // word pairing, and places each suggestion into a ListTile
          // row. For even rows, the function adds a ListTile row for
          // the word pairing. For odd rows, the function adds a 
          // Divider widget to visually separate the entries. Note that
          // the divider may be difficult to see on smaller devices.
          itemBuilder: (BuildContext _context, int i) {
            // Add a one-pixel-high divider widget before each row 
            // in the ListView.
            if (i.isOdd) {
              return Divider();
            }

            // The syntax "i ~/ 2" divides i by 2 and returns an 
            // integer result.
            // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
            // This calculates the actual number of word pairings 
            // in the ListView,minus the divider widgets.
            final int index = i ~/ 2;
            // If you've reached the end of the available word
            // pairings...
            if (index >= _suggestions.length) {
              // ...then generate 10 more and add them to the 
              // suggestions list.
              _suggestions.addAll(generateWordPairs().take(10));
            }
            return _buildRow(_suggestions[index]);
          }
        );
      } 
      
        Widget _buildRow(WordPair pair) {
        final alreadySaved = _saved.contains(pair);  // NEW
          return ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
          trailing: Icon(   // NEW from here... 
            alreadySaved ? Icons.thumb_up: Icons.thumb_up_alt_outlined, //so i bet this is the heart icon name
            color: alreadySaved ? Colors.purple : null, // changes the state icon to yellow (color selected) 
          ), onTap: () {      // NEW lines from here...
            setState(() { // this reads the state of the specific tiem tapped 
              if (alreadySaved) { // if the heart is already marked, 
                _saved.remove(pair); // this removes the heart
              } else { //otherwise, if it is not yet marked 
                _saved.add(pair); //it marks this making it a favorite
              } 
            });
          },               // ... to here.
        );
        } 
        void _pushSaved() {
          Navigator.of(context).push(
            // NEW lines from here...
            MaterialPageRoute<void>(
              builder: (BuildContext context) {
                final tiles = _saved.map( // this one was based on the saved names mention above (line 50)
                  (WordPair pair) {
                    return ListTile(
                      title: Text(
                        pair.asPascalCase,
                        style: _biggerFont,
                      ),
                    );
                  },
                );
                final divided = tiles.isNotEmpty
                    ? ListTile.divideTiles(context: context, tiles: tiles).toList()
                    : <Widget>[];

                return Scaffold(
                  appBar: AppBar(
                    title: Text('Words you Liked'),
                  ),
                  body: ListView(children: divided),
                );
              },
            ), 
          );
        }
        // really! i must be careful more.. one ,mistake can really mess this up
}

// part4 : so here we can see that it cant really be pressed.... yet. because we are still filling
//in the how it is placed. the hearts already have conditions to turn red but we didnt have yet a way to tap it ..yet
// there are if statements in place ("?") to fill in the necessary conditions. since there arent yet... lets continue :)

