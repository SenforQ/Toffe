import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class PostToffePage extends StatefulWidget {
  const PostToffePage({super.key});

  @override
  State<PostToffePage> createState() => _PostToffePageState();
}

class _PostToffePageState extends State<PostToffePage> {
  final TextEditingController _challengeNameController = TextEditingController();
  final TextEditingController _storyController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _videoFile;
  VideoPlayerController? _videoController;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _challengeNameController.dispose();
    _storyController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    try {
      final XFile? video = await _imagePicker.pickVideo(
        source: ImageSource.gallery,
      );

      if (video != null) {
        setState(() {
          _videoFile = video;
        });
        _initializeVideoPlayer(video.path);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pick video: $e')),
        );
      }
    }
  }

  Future<void> _initializeVideoPlayer(String path) async {
    _videoController?.dispose();
    _videoController = VideoPlayerController.file(File(path));
    await _videoController!.initialize();
    setState(() {});
  }

  void _clearAllData() {
    setState(() {
      _challengeNameController.clear();
      _storyController.clear();
      _videoFile = null;
      _videoController?.dispose();
      _videoController = null;
    });
  }

  Future<void> _submitChallenge() async {
    if (_challengeNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the challenge name')),
      );
      return;
    }

    if (_videoFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload a video')),
      );
      return;
    }

    if (_storyController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please tell the story behind your ink')),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    await Future.delayed(const Duration(seconds: 5));

    if (mounted) {
      setState(() {
        _isSubmitting = false;
      });

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Submission Successful!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          content: const Text(
            'Your challenge video has been submitted successfully. It will be reviewed by our team within 24 hours. Thank you for your patience!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _clearAllData();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD272FF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Upload challenge video',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        toolbarOpacity: 1.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/base_post_content_bg.webp'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: statusBarHeight + 20),
                _buildQuestion1(),
                const SizedBox(height: 32),
                _buildQuestion2(),
                const SizedBox(height: 32),
                _buildQuestion3(),
                const SizedBox(height: 40),
                _buildSubmitButton(),
                const SizedBox(height: 79),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: const Offset(4, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.of(context).pop(),
          customBorder: const CircleBorder(),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Q1: Enter the name of the challenge you want to participate in',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFD272FF).withOpacity(0.3),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            controller: _challengeNameController,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintText: 'Yes, like: [animal, flower, date...]',
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.6),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestion2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Q2: Upload Video',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Must be a video • No offensive content',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: _pickVideo,
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: const Color(0xFFD272FF).withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: _videoController != null &&
                    _videoController!.value.isInitialized
                ? Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: AspectRatio(
                          aspectRatio: _videoController!.value.aspectRatio,
                          child: VideoPlayer(_videoController!),
                        ),
                      ),
                      Positioned.fill(
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              if (_videoController!.value.isPlaying) {
                                _videoController!.pause();
                              } else {
                                _videoController!.play();
                              }
                              setState(() {});
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _videoController!.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.play_circle_outline,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Tap to upload video',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestion3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Q3: Tell the story behind your ink... (Why does it fit this challenge?)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFD272FF).withOpacity(0.3),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            controller: _storyController,
            maxLines: 4,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintText: 'Yes, like: [animal, flower, date...]',
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.6),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: GestureDetector(
        onTap: _isSubmitting ? null : _submitChallenge,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFF477FF), Color(0xFFD272FF)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: _isSubmitting
              ? const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
              : const Text(
                  'No problem! Submit',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
