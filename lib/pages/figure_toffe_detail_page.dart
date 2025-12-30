import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'image_full_page.dart';
import 'video_full_page.dart';
import 'figure_chat_toffe_page.dart';
import 'figure_call_detail_page.dart';
import 'report_page.dart';

class FigureToffeDetailPage extends StatefulWidget {
  final Map<String, dynamic> character;

  const FigureToffeDetailPage({super.key, required this.character});

  @override
  State<FigureToffeDetailPage> createState() => _FigureToffeDetailPageState();
}

class _FigureToffeDetailPageState extends State<FigureToffeDetailPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    
    final userIcon = widget.character['toffeUserIcon'] as String?;
    final nickName = widget.character['toffeNickName'] as String?;
    final motto = widget.character['toffeShowMotto'] as String?;
    final photoArray = widget.character['toffeShowPhotoArray'] as List<dynamic>?;
    final videoArray = widget.character['toffeShowVideoArray'] as List<dynamic>?;
    final thumbnailArray = widget.character['toffeShowThumbnailArray'] as List<dynamic>?;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          nickName != null ? '@$nickName' : 'Character Detail',
          style: const TextStyle(color: Colors.white),
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
        actions: [
          _buildReportButton(context),
        ],
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
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: statusBarHeight),
                _buildUserInfoSection(userIcon, nickName, motto),
                const SizedBox(height: 32),
                if (photoArray != null && photoArray.isNotEmpty)
                  _buildPhotoSection(photoArray),
                if (videoArray != null && thumbnailArray != null && videoArray.isNotEmpty)
                  _buildVideoSection(videoArray, thumbnailArray),
                const SizedBox(height: 20),
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

  Widget _buildReportButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showActionSheet(context),
          customBorder: const CircleBorder(),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.report_problem,
              color: Colors.black87,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showActionSheet(BuildContext context) async {
    final nickName = widget.character['toffeNickName'] as String?;
    if (nickName == null) return;

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReportPage(character: widget.character),
                ),
              );
            },
            child: const Text('Report'),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              await _blockUser(nickName);
              if (mounted) {
                Navigator.of(context).popUntil((route) {
                  return route.isFirst || route.settings.name == '/';
                });
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('User has been blocked'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              }
            },
            child: const Text('Block'),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              await _muteUser(nickName);
              if (mounted) {
                Navigator.of(context).popUntil((route) {
                  return route.isFirst || route.settings.name == '/';
                });
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('User has been muted'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              }
            },
            child: const Text('Mute'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          isDefaultAction: true,
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  Future<void> _blockUser(String nickName) async {
    final prefs = await SharedPreferences.getInstance();
    final blockedUsers = (prefs.getStringList('blocked_users') ?? []).toSet();
    blockedUsers.add(nickName);
    await prefs.setStringList('blocked_users', blockedUsers.toList());
    await prefs.setBool('need_refresh_home', true);
  }

  Future<void> _muteUser(String nickName) async {
    final prefs = await SharedPreferences.getInstance();
    final mutedUsers = (prefs.getStringList('muted_users') ?? []).toSet();
    mutedUsers.add(nickName);
    await prefs.setStringList('muted_users', mutedUsers.toList());
    await prefs.setBool('need_refresh_home', true);
  }

  Widget _buildUserInfoSection(String? userIcon, String? nickName, String? motto) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (userIcon != null)
                ClipOval(
                  child: Image.asset(
                    userIcon,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              if (userIcon != null) const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (nickName != null)
                      Text(
                        '@$nickName',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (motto != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        motto,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FigureChatToffePage(
                          character: widget.character,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD272FF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Chat',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FigureCallDetailPage(
                          character: widget.character,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFD272FF),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: const BorderSide(
                        color: Color(0xFFD272FF),
                        width: 2,
                      ),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Call',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoSection(List<dynamic> photoArray) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Photos',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemCount: photoArray.length,
          itemBuilder: (context, index) {
            final imagePath = photoArray[index] as String;
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageFullPage(
                      imagePath: imagePath,
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildVideoSection(List<dynamic> videoArray, List<dynamic> thumbnailArray) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        const Text(
          'Videos',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 16 / 9,
          ),
          itemCount: videoArray.length,
          itemBuilder: (context, index) {
            final videoPath = videoArray[index] as String;
            final thumbnailPath = index < thumbnailArray.length
                ? thumbnailArray[index] as String
                : null;
            
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoFullPage(
                      videoPath: videoPath,
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: thumbnailPath != null
                        ? Image.asset(
                            thumbnailPath,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              );
                            },
                          )
                        : Container(
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.video_library,
                              size: 48,
                              color: Colors.grey,
                            ),
                          ),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

