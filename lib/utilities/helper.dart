import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<ImageSource?> chooseImageSource(BuildContext context) {
  return showGeneralDialog<ImageSource>(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Pilih Gambar",
    pageBuilder: (context, animation, secondaryAnimation) =>
        SimpleDialog(title: const Text("Pilih Gambar Dari : "), children: [
      SimpleDialogOption(
        onPressed: () {
          Navigator.pop(context, ImageSource.gallery);
        },
        padding: const EdgeInsets.all(10),
        child: const Icon(Icons.image_search_rounded, size: 55),
      ),
      SimpleDialogOption(
        onPressed: () {
          Navigator.pop(context, ImageSource.camera);
        },
        padding: const EdgeInsets.all(10),
        child: const Icon(Icons.camera_alt_rounded, size: 55),
      )
    ]),
  );
}

Future<void> pickImage(
    {required ImageSource source, required Function(XFile?) onChoosed}) async {
  final picker = ImagePicker();
  final image = await picker.pickImage(source: source);

  onChoosed(image);
}
