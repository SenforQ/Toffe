import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/video_comment_sheet.dart';

class VideoFullPage extends StatefulWidget {
  final String videoPath;

  const VideoFullPage({super.key, required this.videoPath});

  @override
  State<VideoFullPage> createState() => _VideoFullPageState();
}

class _VideoFullPageState extends State<VideoFullPage> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _isLoading = true;
  bool _isLiked = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _loadLikeStatus();
    _initializeVideo();
  }

  Future<void> _loadLikeStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLiked = prefs.getBool('video_liked_${widget.videoPath}') ?? false;
    });
  }

  Future<void> _toggleLike() async {
    setState(() {
      _isLiked = !_isLiked;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('video_liked_${widget.videoPath}', _isLiked);
  }

  Future<void> _initializeVideo() async {
    try {
      _controller = VideoPlayerController.asset(widget.videoPath);
      await _controller!.initialize();
      _controller!.addListener(() {
        if (mounted) {
          setState(() {
            _isPlaying = _controller!.value.isPlaying;
            _currentPosition = _controller!.value.position;
            _totalDuration = _controller!.value.duration;
          });
        }
      });
      if (mounted) {
        setState(() {
          _isInitialized = true;
          _isLoading = false;
        });
        _controller!.play();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_controller != null && _isInitialized) {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
      } else {
        _controller!.play();
      }
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  Widget _buildProgressBar(double screenWidth) {
    final progress = _totalDuration.inMilliseconds > 0
        ? _currentPosition.inMilliseconds / _totalDuration.inMilliseconds
        : 0.0;

    return Container(
      width: screenWidth,
      height: 107,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img_mask.webp'),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                    child: Stack(
                      children: [
                        FractionallySizedBox(
                          widthFactor: progress.clamp(0.0, 1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFD272FF),
                                  Color(0xFFF477FF),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(1.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${_formatDuration(_currentPosition)} / ${_formatDuration(_totalDuration)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        toolbarOpacity: 1.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
        ),
        leading: _buildBackButton(context),
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: Colors.black,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : _isInitialized && _controller != null
                ? Stack(
                    children: [
                      Center(
                        child: AspectRatio(
                          aspectRatio: _controller!.value.aspectRatio,
                          child: VideoPlayer(_controller!),
                        ),
                      ),
                      Positioned.fill(
                        child: GestureDetector(
                          onTap: _togglePlayPause,
                          child: Container(
                            color: Colors.transparent,
                            child: Center(
                              child: AnimatedOpacity(
                                opacity: _isPlaying ? 0.0 : 1.0,
                                duration: const Duration(milliseconds: 300),
                                child: Image.asset(
                                  'assets/icon_play.webp',
                                  width: 70,
                                  height: 70,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.6),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        bottom: 107,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: _toggleLike,
                              child: Image.asset(
                                _isLiked
                                    ? 'assets/icon_collect_nor.webp'
                                    : 'assets/icon_collect_pre.webp',
                                width: 40,
                                height: 40,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      _isLiked ? Icons.favorite : Icons.favorite_border,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => VideoCommentSheet(
                                    videoPath: widget.videoPath,
                                  ),
                                );
                              },
                              child: Image.asset(
                                'assets/icon_video_comment.webp',
                                width: 40,
                                height: 40,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.comment,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: _buildProgressBar(screenWidth),
                      ),
                    ],
                  )
                : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error,
                          size: 48,
                          color: Colors.red,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Failed to load video',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}

