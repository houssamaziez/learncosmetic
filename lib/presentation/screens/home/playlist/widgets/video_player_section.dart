import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerSection extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerSection({Key? key, required this.videoUrl})
    : super(key: key);

  @override
  State<VideoPlayerSection> createState() => _VideoPlayerSectionState();
}

class _VideoPlayerSectionState extends State<VideoPlayerSection> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();

    // تحكم في الفيديو
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {}); // إعادة بناء بعد التحميل
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          autoPlay: false,
          looping: false,
          materialProgressColors: ChewieProgressColors(
            playedColor: Colors.redAccent,
            backgroundColor: Colors.grey.shade300,
            bufferedColor: Colors.red.shade100,
          ),
          placeholder: Container(color: Colors.black12),
          autoInitialize: true,
        );
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_chewieController == null ||
        !_videoPlayerController.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return AspectRatio(
      aspectRatio: _videoPlayerController.value.aspectRatio,
      child: Chewie(controller: _chewieController!),
    );
  }

  // return Container();
}
