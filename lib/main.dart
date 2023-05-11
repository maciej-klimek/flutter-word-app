import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WordApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(255, 53, 53, 53),
        ),
      ),
      home: const MyHomePage(title: 'WordApp'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, String>> _wordList = [];

  void _addWord(String word, String translation) {
    setState(() {
      _wordList.add({'word': word, 'translation': translation});
    });
  }

  void _removeWord(int index) {
    setState(() {
      _wordList.removeAt(index);
    });
  }

  void _editWord(int index, String newWord, String newTranslation) {
    _wordList[index] = {'word': newWord, 'translation': newTranslation};
  }

  void _showAddWordDialog() {
    TextEditingController wordInput = TextEditingController();
    TextEditingController translationInput = TextEditingController();

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
                  _addWord(word, translation);
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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _editWord(index, word, translation);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _removeWord(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddWordDialog,
        tooltip: 'Add Word',
        backgroundColor: const Color.fromARGB(255, 53, 53, 53),
        child: const Icon(Icons.add),
      ),
    );
  }
}
