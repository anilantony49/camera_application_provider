import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class InputImage extends StatefulWidget {
  final Function imageSaveAt;
  const InputImage(this.imageSaveAt, {super.key});

  @override
  State<InputImage> createState() => _InputImageState();
}

class _InputImageState extends State<InputImage> {
  File? _imageFile;
  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _imageFile = File(imageFile.path);
    });
    final apDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final saveImagePath = await _imageFile!.copy('${apDir.path}/$fileName');

    widget.imageSaveAt(saveImagePath);
  }

  Future<void> _galleryPicture() async {
    final picker = ImagePicker();
    final imageFile =
        await picker.pickImage(source: ImageSource.gallery, maxWidth: 600);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _imageFile = File(imageFile.path);
    });
    final apDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final saveImagePath = await _imageFile!.copy('${apDir.path}/$fileName');

    widget.imageSaveAt(saveImagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 200,
          width: 200,
          decoration:
              BoxDecoration(border: Border.all(width: 2, color: Colors.grey)),
          child: _imageFile != null
              ? Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                )
              : Text('No image'),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: _galleryPicture,
                icon: Icon(Icons.image),
                label: Text('Add Image')),
            TextButton.icon(
                onPressed: () {
                  _takePicture();
                },
                icon: Icon(Icons.camera),
                label: Text('Take Picture')),
          ],
        )
      ],
    );
  }
}
