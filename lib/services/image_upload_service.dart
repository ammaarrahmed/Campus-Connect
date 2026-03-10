import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ImageUploadService {
  final ImagePicker _picker = ImagePicker();

  // Cloudinary Configuration
  // TODO: Replace these with your Cloudinary credentials
  // Get them from: https://cloudinary.com/console
  static const String _cloudName = 'duxdxdovl';
  static const String _uploadPreset = 'campus_connect_posts';

  String get _uploadUrl =>
      'https://api.cloudinary.com/v1_1/$_cloudName/image/upload';

  Future<File?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }

  Future<File?> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      print('Error taking photo: $e');
      return null;
    }
  }

  Future<String?> uploadPostImage(File imageFile, String userId) async {
    try {
      if (_cloudName == 'YOUR_CLOUD_NAME' ||
          _uploadPreset == 'YOUR_UPLOAD_PRESET') {
        print('Error: Please configure Cloudinary credentials');
        print('See docs/LOCAL_DEVELOPMENT.md for setup instructions');
        return null;
      }

      final request = http.MultipartRequest('POST', Uri.parse(_uploadUrl));
      request.fields['upload_preset'] = _uploadPreset;
      request.fields['folder'] = 'campus_connect/posts';

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      request.fields['public_id'] = '${userId}_$timestamp';

      final imageBytes = await imageFile.readAsBytes();
      final multipartFile = http.MultipartFile.fromBytes(
        'file',
        imageBytes,
        filename: 'post_image.jpg',
      );
      request.files.add(multipartFile);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final imageUrl = jsonResponse['secure_url'] as String;
        print('Image uploaded successfully: $imageUrl');
        return imageUrl;
      } else {
        print('Cloudinary upload failed: ${response.statusCode}');
        print('Response: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error uploading image to Cloudinary: $e');
      return null;
    }
  }

  Future<bool> deletePostImage(String imageUrl) async {
    print('Note: Image deletion requires Cloudinary API authentication');
    return false;
  }
}
