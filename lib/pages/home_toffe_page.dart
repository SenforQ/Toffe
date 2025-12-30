import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'painting_ai_page.dart';
import 'report_page.dart';
import 'image_toffe_page.dart';
import 'figure_toffe_detail_page.dart';

class HomeToffePage extends StatefulWidget {
  const HomeToffePage({super.key});

  @override
  State<HomeToffePage> createState() => _HomeToffePageState();
}

class _HomeToffePageState extends State<HomeToffePage> {
  List<Map<String, dynamic>> _characters = [];
  Set<String> _blockedUsers = {};
  Set<String> _mutedUsers = {};

  @override
  void initState() {
    super.initState();
    _loadBlockedAndMutedUsers();
    _loadCharacters();
  }

  Future<void> _checkAndRefresh() async {
    final prefs = await SharedPreferences.getInstance();
    final needRefresh = prefs.getBool('need_refresh_home') ?? false;
    if (needRefresh) {
      await prefs.setBool('need_refresh_home', false);
      await _loadBlockedAndMutedUsers();
      await _loadCharacters();
    }
  }

  Future<void> _loadBlockedAndMutedUsers() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _blockedUsers = (prefs.getStringList('blocked_users') ?? []).toSet();
      _mutedUsers = (prefs.getStringList('muted_users') ?? []).toSet();
    });
  }

  Future<void> _loadCharacters() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/toffe_figure.json');
      final List<dynamic> jsonData = jsonDecode(jsonString);
      final allCharacters = jsonData.cast<Map<String, dynamic>>();
      
      // Filter out blocked and muted users
      final filteredCharacters = allCharacters.where((character) {
        final nickName = character['toffeNickName'] as String?;
        if (nickName == null) return false;
        return !_blockedUsers.contains(nickName) && !_mutedUsers.contains(nickName);
      }).toList();
      
      setState(() {
        _characters = filteredCharacters;
      });
    } catch (e) {
      print('Error loading characters: $e');
    }
  }

  Future<void> _showActionSheet(BuildContext context, Map<String, dynamic> character) async {
    final nickName = character['toffeNickName'] as String?;
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
                  builder: (context) => ReportPage(character: character),
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
                // Pop all routes until we reach the root (MainToffePage)
                Navigator.of(context).popUntil((route) {
                  return route.isFirst || route.settings.name == '/';
                });
                // Refresh data
                await _loadBlockedAndMutedUsers();
                await _loadCharacters();
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
                // Pop all routes until we reach the root (MainToffePage)
                Navigator.of(context).popUntil((route) {
                  return route.isFirst || route.settings.name == '/';
                });
                // Refresh data
                await _loadBlockedAndMutedUsers();
                await _loadCharacters();
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
    _blockedUsers.add(nickName);
    await prefs.setStringList('blocked_users', _blockedUsers.toList());
  }

  Future<void> _muteUser(String nickName) async {
    final prefs = await SharedPreferences.getInstance();
    _mutedUsers.add(nickName);
    await prefs.setStringList('muted_users', _mutedUsers.toList());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkAndRefresh();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/base_post_content_bg.webp'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: statusBarHeight),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Inspiration',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PaintingAiPage(),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/home_top_content_bg.webp',
                    width: screenWidth - 40,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Popular Tattoos',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (_characters.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: MasonryGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _characters.length,
                    itemBuilder: (context, index) {
                      final character = _characters[index];
                      final photoArray = character['toffeShowPhotoArray'] as List<dynamic>?;
                      if (photoArray == null || photoArray.length < 2) {
                        return const SizedBox.shrink();
                      }
                      final imagePath = photoArray[1] as String;
                      final userIcon = character['toffeUserIcon'] as String?;
                      final nickName = character['toffeNickName'] as String?;
                      
                      return GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FigureToffeDetailPage(
                                character: character,
                              ),
                            ),
                          );
                          if (mounted) {
                            await _loadBlockedAndMutedUsers();
                            await _loadCharacters();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ImageToffePage(
                                            character: character,
                                            imagePath: imagePath,
                                          ),
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      child: Image.asset(
                                        imagePath,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            height: 200,
                                            color: Colors.grey[300],
                                            child: const Icon(
                                              Icons.error,
                                              color: Colors.red,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: () => _showActionSheet(context, character),
                                      child: Container(
                                        width: 28,
                                        height: 28,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.error_outline,
                                          color: Colors.black,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    if (userIcon != null)
                                      ClipOval(
                                        child: Image.asset(
                                          userIcon,
                                          width: 24,
                                          height: 24,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              width: 24,
                                              height: 24,
                                              color: Colors.grey[300],
                                              child: const Icon(
                                                Icons.person,
                                                size: 16,
                                                color: Colors.grey,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    if (userIcon != null) const SizedBox(width: 8),
                                    if (nickName != null)
                                      Expanded(
                                        child: Text(
                                          '@$nickName',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

