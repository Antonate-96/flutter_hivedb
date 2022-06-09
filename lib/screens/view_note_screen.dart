import 'dart:io';

import 'package:flutter/material.dart';

class ViewNoteScreen extends StatelessWidget {
  final String? title;
  final String? description;
  final String? imageUrl;

  const ViewNoteScreen(
      {Key? key,
      @required this.title,
      @required this.description,
      @required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title.toString()),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Text(
                description.toString(),
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 50,
              ),
              Image.file(
                File(imageUrl!),
              )
            ],
          ),
        ),
      ),
    );
  }
}
