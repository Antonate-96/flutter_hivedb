import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hive_image/models/note.dart';
import 'package:flutter_hive_image/screens/add_note.dart';
import 'package:flutter_hive_image/screens/view_note_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({Key? key}) : super(key: key);

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NOTE'),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Note>('note').listenable(),
          builder: (context, Box<Note> box, _) {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, i) {
                final note = box.getAt(i);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ViewNoteScreen(
                                  title: note!.title,
                                  description: note.description,
                                  imageUrl: note.imageUrl),
                            ),
                          );
                        },
                        leading: Image.file(File(
                          note!.imageUrl.toString(),
                        )),
                        title: Text(note.title.toString()),
                        trailing: IconButton(
                          onPressed: () {
                            box.deleteAt(i);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddNoteScreen(),
              ),
            );
          },
          label: const Text('+ | Add Note')),
    );
  }
}
