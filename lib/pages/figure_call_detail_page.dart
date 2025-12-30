import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

class FigureCallDetailPage extends StatefulWidget {
  final Map<String, dynamic> character;

  const FigureCallDetailPage({super.key, required this.character});

  @override
  State<FigureCallDetailPage> createState() => _FigureCallDetailPageState();
}

class _FigureCallDetailPageState extends State<FigureCallDetailPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Timer? _autoHangupTimer;
  DateTime _callStartTime = DateTime.now();
  Timer? _callDurationTimer;
  String _callDuration = '00:00';

  String? get _characterNickName => widget.character['toffeNickName'] as String?;
  String? get _characterIcon => widget.character['toffeUserIcon'] as String?;
  List<dynamic>? get _photoArray => widget.character['toffeShowPhotoArray'] as List<dynamic>?;

  String? get _backgroundImage {
    if (_photoArray != null && _photoArray!.isNotEmpty) {
      return _photoArray!.last as String;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _startCall();
  }

  Future<void> _startCall() async {
    try {
      await _audioPlayer.play(AssetSource('toffemusic.mp3'));
    } catch (e) {
      print('Error playing audio: $e');
    }

    _callStartTime = DateTime.now();
    _updateCallDuration();

    _autoHangupTimer = Timer(const Duration(seconds: 30), () {
      _hangup();
    });

    _callDurationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        _updateCallDuration();
      } else {
        timer.cancel();
      }
    });
  }

  void _updateCallDuration() {
    if (mounted) {
      final duration = DateTime.now().difference(_callStartTime);
      final minutes = duration.inMinutes.remainder(60);
      final seconds = duration.inSeconds.remainder(60);
      setState(() {
        _callDuration = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
      });
    }
  }

  Future<void> _hangup() async {
    _autoHangupTimer?.cancel();
    _callDurationTimer?.cancel();
    try {
      await _audioPlayer.stop();
    } catch (e) {
      print('Error stopping audio: $e');
    }
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _autoHangupTimer?.cancel();
    _callDurationTimer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          _characterNickName ?? 'Call',
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
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
      body: Stack(
        children: [
          if (_backgroundImage != null)
            Positioned.fill(
              child: Image.asset(
                _backgroundImage!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[900],
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.white54,
                        size: 64,
                      ),
                    ),
                  );
                },
              ),
            )
          else
            Container(
              color: Colors.grey[900],
              child: const Center(
                child: Icon(
                  Icons.image_not_supported,
                  color: Colors.white54,
                  size: 64,
                ),
              ),
            ),
          Positioned(
            top: statusBarHeight + 60,
            left: 20,
            child: _buildCallerInfoCapsule(),
          ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: _buildHangupButton(),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Calling the contact now...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFD272FF),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _hangup(),
          customBorder: const CircleBorder(),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCallerInfoCapsule() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFD272FF).withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFD272FF),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_characterIcon != null)
            ClipOval(
              child: Image.asset(
                _characterIcon!,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 40,
                    height: 40,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.person,
                      size: 20,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          if (_characterIcon != null) const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_characterNickName != null)
                Text(
                  _characterNickName!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              Text(
                _callDuration,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHangupButton() {
    return GestureDetector(
      onTap: _hangup,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.5),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: const Icon(
          Icons.call_end,
          color: Colors.white,
          size: 36,
        ),
      ),
    );
  }
}

