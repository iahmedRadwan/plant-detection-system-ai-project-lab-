import 'dart:io';

import 'package:ai_project_lab_pannon/shared/style/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../shared/style/fonts_manager.dart';
import '../home_page.dart';

class UploadImage extends StatefulWidget {
  UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _showImagePicker();
      },
      child: Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: ColorManagerHelper.kBlackColor, width: 1),
          borderRadius: BorderRadius.circular(25),
        ),
        child: selectedImage != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.file(
                  File(selectedImage!.path),
                  fit: BoxFit.cover,
                ),
              )
            : const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                      image: AssetImage(
                        "assets/images/upload_image_logo.png",
                      ),
                      color: ColorManagerHelper.kMainColor,
                      height: 160),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Upload Image To Discover Disease",
                      style: FontsManagerHelper.bodyLarge),
                ],
              ),
      ),
    );
  }

  Future<void> _showImagePicker() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Choose an Option',
                style: FontsManagerHelper.bodyLarge,
              ),
              const SizedBox(height: 10),
              Divider(
                color: Theme.of(context).dividerColor,
                thickness: 1,
              ),
              ListTile(
                leading: Icon(IconlyBroken.image,
                    color: Theme.of(context).iconTheme.color),
                title: const Text(
                  'Pick from Gallery',
                  style: FontsManagerHelper.bodyMedium,
                ),
                onTap: () async {
                  Navigator.of(context).pop();
                  final pickedFile =
                      await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    selectedImage = pickedFile;
                  });
                },
              ),
              ListTile(
                leading: Icon(IconlyBroken.camera,
                    color: Theme.of(context).iconTheme.color),
                title: const Text(
                  'Take a Photo',
                  style: FontsManagerHelper.bodyMedium,
                ),
                onTap: () async {
                  Navigator.of(context).pop();
                  final pickedFile =
                      await _picker.pickImage(source: ImageSource.camera);
                  setState(() {
                    selectedImage = pickedFile;
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
