import 'package:image_picker/image_picker.dart';

Future<XFile?> pickFromGallery() async {
  final ImagePicker picker = ImagePicker();
  final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
  return photo;
}

Future<XFile?> takeFromCamera() async {
  final ImagePicker picker = ImagePicker();
  final XFile? photo = await picker.pickImage(source: ImageSource.camera);
  return photo;
}
