// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PhotoSelectionDialog extends StatelessWidget {
  const PhotoSelectionDialog({super.key});

  // Function to handle camera selection
  Future<String?> _pickImageFromCamera(BuildContext context) async {
    final PermissionStatus permissionStatus = await Permission.camera.request();

    if (permissionStatus == PermissionStatus.granted) {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        Navigator.of(context).pop(); // Close the dialog after selection
        return image.path; // Return the selected image path
      } else {
        // If no image is selected (user backed out/cancelled), handle it here
        Fluttertoast.showToast(
          msg: 'No image selected or action cancelled.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        return null;
      }
    } else {
      // If permission was denied, show a toast
      Fluttertoast.showToast(
        msg: 'Action cancelled. Camera permission denied.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      Navigator.of(context).pop(); // Optionally close the dialog
    }
    return null;
  }

  Future<String?> _pickImageFromGallery(BuildContext context) async {
    final PermissionStatus permissionStatus = await Permission.photos.request();

    if (permissionStatus == PermissionStatus.granted) {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        Navigator.of(context).pop(); // Close the dialog after selection
        return image
            .path; // Return the selected image path        Navigator.of(context).pop(); // Close the dialog after selection
      } else {
        Fluttertoast.showToast(
          msg: 'No image selected or action cancelled.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        Navigator.of(context).pop(); // Close the dialog
        return null;
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Action cancelled. Gallery permission denied.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      Navigator.of(context).pop(); // Optionally close the dialog
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Photo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.camera),
            title: const Text('Take a Picture'),
            onTap: () => _pickImageFromCamera(context),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Choose from Gallery'),
            onTap: () async {
              final selectedImagePath = await _pickImageFromGallery(context);
              Navigator.of(context).pop(selectedImagePath);
            },
          ),
          ListTile(
            leading: const Icon(Icons.cancel),
            title: const Text('Cancel'),
            onTap: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      ),
    );
  }
}
