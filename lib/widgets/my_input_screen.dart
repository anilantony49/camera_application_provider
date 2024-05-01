import 'dart:io';

import 'package:camera_application1/models/models.dart';
import 'package:camera_application1/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyInputScreen extends StatefulWidget {
  static const routName = 'MyInputScreen';
  const MyInputScreen({super.key});

  @override
  State<MyInputScreen> createState() => _MyInputScreenState();
}

class _MyInputScreenState extends State<MyInputScreen> {
  final _titleController = TextEditingController();
  final _storyController = TextEditingController();
  File? savedImage;

  void savedImages(File image) {
    savedImage = image;
  }

  void onSave() {
    if (_titleController.text.isEmpty ||
        _storyController.text.isEmpty ||
        savedImage == null) {
      return;
    } else {
      Provider.of<ImageFile>(context, listen: false).addImagePlace(
          _titleController.text, _storyController.text, savedImage!);
          Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Page'),
        actions: [IconButton(onPressed: onSave, icon: const Icon(Icons.save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _storyController,
                decoration: const InputDecoration(labelText: 'Story'),
              ),
              const SizedBox(
                height: 50,
              ),
              InputImage(savedImages)
            ],
          ),
        ),
      ),
    );
  }
}
