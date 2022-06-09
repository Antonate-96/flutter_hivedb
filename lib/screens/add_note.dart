import 'dart:io';

import 'package:flutter_hive_image/models/note.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  XFile? _image;
  String? title;
  String? description;

  getImageGallery() async {
    final image =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  getImageCamera() async {
    final image =
        await ImagePicker.platform.getImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  submmitData() async {
    final isvalid = _formKey.currentState!.validate();
    if (isvalid) {
      Hive.box<Note>('note').add(
        Note(title: title, description: description, imageUrl: _image!.path),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Note'),
        actions: [
          IconButton(onPressed: submmitData, icon: const Icon(Icons.save))
        ],
      ),
      body: SafeArea(
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                  autocorrect: false,
                  onChanged: (val) {
                    setState(() {
                      title = val;
                    });
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Description'),
                  ),
                  autocorrect: false,
                  onChanged: (val) {
                    setState(() {
                      description = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                _image == null
                    ? Column(
                        children: [
                          const SizedBox(height: 20),
                          const Icon(
                            Icons.no_photography_outlined,
                            size: 100,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: getImageGallery,
                                child: const Text('Gallery'),
                              ),
                              const Text(
                                '  /  ',
                                style: TextStyle(fontSize: 30),
                              ),
                              ElevatedButton(
                                onPressed: getImageCamera,
                                child: const Text('Camera'),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Image.file(
                        File(_image!.path),
                      )
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _image = null;
          setState(() {});
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
