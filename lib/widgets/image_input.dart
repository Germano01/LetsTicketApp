import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ImageInput extends StatefulWidget {
  final ValueChanged<File>? onImageSelected;
  final TextEditingController?
      imageController; // Adicionando o TextEditingController

  ImageInput({Key? key, this.onImageSelected, this.imageController})
      : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _imageFile;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      if (widget.onImageSelected != null) {
        widget.onImageSelected!(_imageFile!);
      }
      if (widget.imageController != null) {
        widget.imageController!.text = basename(_imageFile!.path);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _getImage(ImageSource.gallery),
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              image: _imageFile != null
                  ? DecorationImage(
                      image: FileImage(_imageFile!), fit: BoxFit.cover)
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.image, size: 32, color: Colors.grey[400]),
                const SizedBox(width: 8),
                _imageFile != null
                    ? Text(
                        _imageFile!.path.split('/').last,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      )
                    : const Text(
                        'Selecione uma imagem',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
