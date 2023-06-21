import 'dart:html';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Word app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(255, 53, 53, 53),
        ),
      ),
      home: const GroupPage(title: 'Word App'),
    );
  }
}

class GroupPage extends StatefulWidget {
  const GroupPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<GroupPage> createState() => _GroupPage();
}

class _GroupPage extends State<GroupPage> {
  final List<Map<String, String>> _wordList = [];

  void _addWordItem(String word, String translation) {
    setState(() {
      _wordList.add({'word': word, 'translation': translation});
    });
  }

  void _removeWordItem(int index) {
    setState(() {
      _wordList.removeAt(index);
    });
  }

  void _editWordItem(int index, String word, String translation) {
    setState(() {
      _wordList[index]['word'] = word;
      _wordList[index]['translation'] = translation;
    });
  }

  void _showAddWordDialog(
      String word, String translation, bool newWord, int index) {
    TextEditingController wordInput = TextEditingController();
    TextEditingController translationInput = TextEditingController();

    wordInput.text = word;
    translationInput.text = translation;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              TextField(
                controller: wordInput,
                decoration: const InputDecoration(hintText: 'Word'),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: translationInput,
                decoration: const InputDecoration(hintText: 'Translation'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                child: const Text('Add Word'),
                onPressed: () {
                  String word = wordInput.text;
                  String translation = translationInput.text;
                  if (word == "" || translation == "") {}
                  if (newWord) {
                    _addWordItem(word, translation);
                  } else {
                    _editWordItem(index, word, translation);
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _wordList.length,
        itemBuilder: (BuildContext context, int index) {
          String word = _wordList[index]['word']!;
          String translation = _wordList[index]['translation']!;
          return ListTile(
              title: Text(word),
              subtitle: Text(translation),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _removeWordItem(index);
                },
              ),
              onTap: () {
                _showAddWordDialog(word, translation, false, index);
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddWordDialog("", "", true, 0);
        },
        tooltip: 'Add Word',
        backgroundColor: const Color.fromARGB(255, 53, 53, 53),
        child: const Icon(Icons.add),
      ),
    );
  }
}
