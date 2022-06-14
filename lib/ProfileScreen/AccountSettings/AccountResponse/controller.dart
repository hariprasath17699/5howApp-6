import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:star_event/ProfileScreen/AccountSettings/AccountResponse/service.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var imageURL = '';

  void uploadImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    isLoading(true);
    if (pickedFile != null) {
      var response = await ImageService.uploadFile(pickedFile.path);

      Get.snackbar('Success', 'Image uploaded successfully',
          margin: EdgeInsets.only(top: 5, left: 10, right: 10));
    }
  }
}
