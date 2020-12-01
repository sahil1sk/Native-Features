import 'dart:io'; // to use File datatype

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path; // helps to construct the path where we store file
import 'package:path_provider/path_provider.dart' as syspaths; // helps to finding the path


class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker(); // initaing // we can also user ImageSource.gallery
    final imageFile = await picker.getImage(
      source: ImageSource.camera, 
      maxWidth: 600
    );
    setState(() {
      _storedImage = File(imageFile.path); // converting into the file path to use
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory(); // we are able to get sd card like syspath.getExter..
    final filename = path.basename(imageFile.path); // here we getting the filename in this way
    final savedImage = await File(imageFile.path).copy('${appDir.path}/$filename'); // so here copy the file to another path
    widget.onSelectImage(savedImage); // passing the saved image
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey
            ),
          ),
          child: _storedImage != null 
          ? Image.file( // helps to set the image which is in file
              _storedImage,
              fit: BoxFit.cover,
              width: double.infinity,
            ) 
          : Text(
            'No IMage Taken',
            textAlign: TextAlign.center,
          ),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}