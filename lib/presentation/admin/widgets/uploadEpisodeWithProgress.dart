import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import '../../controllers/course_screen_controller.dart';

Future<void> uploadEpisodeWithProgress({
  required File imageFile,
  required File videoFile,
  required String title,
  required String description,
  required int playlistId,
  required void Function(double) onProgress,
}) async {
  final uri = Uri.parse("https://test.hatlifood.com/api/episode");
  final CourseScreenController controller = Get.find();

  final request = http.MultipartRequest('POST', uri);
  request.fields['title'] = title;
  request.fields['description'] = description;
  request.fields['playlist_id'] = playlistId.toString();

  final int imageLength = await imageFile.length();
  final int videoLength = await videoFile.length();
  final int totalLength = imageLength + videoLength;

  int bytesSent = 0;

  final imageStream = http.ByteStream(
    imageFile.openRead().transform(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          bytesSent += data.length;
          onProgress(bytesSent / totalLength);
          sink.add(data);
        },
      ),
    ),
  );

  final videoStream = http.ByteStream(
    videoFile.openRead().transform(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          bytesSent += data.length;
          onProgress(bytesSent / totalLength);
          sink.add(data);
        },
      ),
    ),
  );

  request.files.add(
    http.MultipartFile(
      'image',
      imageStream,
      imageLength,
      filename: path.basename(imageFile.path),
    ),
  );

  request.files.add(
    http.MultipartFile(
      'video',
      videoStream,
      videoLength,
      filename: path.basename(videoFile.path),
    ),
  );

  final response = await request.send();

  if (response.statusCode == 201 || response.statusCode == 200) {
    final responseBody = await response.stream.bytesToString();
    controller.getALLHomeEpisodes();
    Get.back();
    print('✅ Success: $responseBody');
  } else {
    final responseBody = await response.stream.bytesToString();
    print('❌ Failed: $responseBody');
  }
}
