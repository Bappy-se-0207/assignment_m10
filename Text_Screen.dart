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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent),
                  child: const Text('Edit Done'),
                ),
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
        backgroundColor: Colors.white,
        actions: const [
          Icon(
            Icons.search,
            color: Colors.blue,
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Add title',
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: 'Add description',
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: addNote,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
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
                            title: const Text('Alert'),
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
