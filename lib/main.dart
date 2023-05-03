import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'English-Polish Word List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(255, 53, 53, 53),
        ),
      ),
      home: MyHomePage(title: 'English-Polish Word List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                decoration: InputDecoration(hintText: 'Translation'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                child: const Text('Add Word'),
                onPressed: () {
                  String word = wordInput.text;
                  String translation = translationInput.text;
                  _addWordItem(word, translation);
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
