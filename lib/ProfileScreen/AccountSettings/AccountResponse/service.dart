import 'package:dio/dio.dart';

class ImageService {
  static Future<dynamic> uploadFile(filePath) async {
    try {
      FormData formData = new FormData.fromMap({
        "image": await MultipartFile.fromFile(filePath, filename: "dp"),
        'email': "hariprasath17699@gmail.com",
        'password': "hariprasath",
        'dob': "17/06/1999",
        'username': "hari",
        'email1': "hariprasath17699@gmail.com",
      });

      Response response = await Dio().put(
        "http://5howapp.com/StarLoginAndRegister/accountSettings.php",
        data: formData,
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    } catch (e) {}
  }
}
