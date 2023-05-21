part of '../auth_screen.dart';

Future<void> _pickImage(ImageSource source, Function(File) setImage) async {
  final ImagePicker picker = ImagePicker();
  final XFile? file = await picker.pickImage(source: source);
  if (file != null) {
    setImage(File(file.path));
  }
}
