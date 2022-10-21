import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File? pickedImage) imagePickerFn;

  const UserImagePicker({
    Key? key,
    required this.imagePickerFn,
  }) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  dynamic _pickedImage;
  bool _changeImage = false;

  final bool _imageTapped = false;

  void _pickImage() async {
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxWidth: 150,
    );
    if (imageFile != null) {
      setState(() {
        _changeImage = true;
        _pickedImage = imageFile.path;
      });
      widget.imagePickerFn(File(_pickedImage));
    } else {
      widget.imagePickerFn(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            height: (_imageTapped) ? 300 : null,
            width: (_imageTapped) ? 300 : null,
            child: (!_changeImage)
                ? const Icon(
                    Iconsax.user,
                    size: 40,
                  )
                : FittedBox(
                    fit: BoxFit.fill,
                    child: CircleAvatar(
                      radius: (_imageTapped) ? 150 : 60,
                      backgroundImage: FileImage(
                        File(
                          _pickedImage,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
