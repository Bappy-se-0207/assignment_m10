import 'package:flutter/material.dart';

class TextScreen extends StatefulWidget {
  const TextScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TextScreenState createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  List<Note> notes = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void addNote() {
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      setState(() {
        notes.add(Note(
          title: titleController.text,
          description: descriptionController.text,
        ));
        titleController.clear();
        descriptionController.clear();
      });
    }
  }

  void editNote(int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextField(
                controller: TextEditingController(text: notes[index].title),
                onChanged: (text) {
                  notes[index].title = text;
                },
                decoration: const InputDecoration(
                  hintText: 'Add title',
                ),
              ),
              TextField(
                controller:
                    TextEditingController(text: notes[index].description),
                onChanged: (text) {
                  notes[index].description = text;
                },
                decoration: const InputDecoration(
                  hintText: 'Add description',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Edit Done'),
              ),
            ],
          ),
        );
      },
    );
  }

  void deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Note App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Add title',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: 'Add description',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: addNote,
            child: const Text('Add'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(notes[index].title),
                    subtitle: Text(notes[index].description),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Options'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  editNote(index);
                                },
                                child: const Text('Edit'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  deleteNote(index);
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Note {
  String title;
  String description;

  Note({
    required this.title,
    required this.description,
  });
}
