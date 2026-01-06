import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'privacy_policy_page.dart';
import 'user_agreement_page.dart';
import 'about_us_page.dart';
import 'toffe_editor_page.dart';
import 'rob_chat_page.dart';
import 'wallet_detail_page.dart';

class MeToffePage extends StatefulWidget {
  const MeToffePage({super.key});

  @override
  State<MeToffePage> createState() => _MeToffePageState();
}

class _MeToffePageState extends State<MeToffePage> {
  String _nickname = 'Toffe';
  String? _avatarPath;
  String? _relativeAvatarPath;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nickname = prefs.getString('user_nickname') ?? 'Toffe';
      _relativeAvatarPath = prefs.getString('user_avatar_path');
    });
    if (_relativeAvatarPath != null) {
      _loadAvatar();
    }
  }

  Future<void> _loadAvatar() async {
    if (_relativeAvatarPath == null) return;
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final fullPath = '${appDir.path}/$_relativeAvatarPath';
      if (await File(fullPath).exists()) {
        setState(() {
          _avatarPath = fullPath;
        });
      }
    } catch (e) {
      print('Error loading avatar: $e');
    }
  }

  Future<void> _navigateToEditor() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ToffeEditorPage(),
      ),
    );

    if (result != null) {
      setState(() {
        _nickname = result['nickname'] ?? 'Toffe';
        _relativeAvatarPath = result['avatarPath'];
      });
      if (_relativeAvatarPath != null) {
        await _loadAvatar();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: screenWidth,
            height: screenHeight,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/base_content_bg.webp'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/me_top_bg.webp',
              width: screenWidth,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            top: statusBarHeight + 20,
            left: 16,
            right: 16,
            child: _buildUserInfoCard(),
          ),
          Positioned(
            top: statusBarHeight + 200,
            left: 16,
            right: 16,
            child: _buildListSection(),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoCard() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: _avatarPath != null
                    ? Image.file(
                        File(_avatarPath!),
                        width: 96,
                        height: 96,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildDefaultAvatar();
                        },
                      )
                    : Image.asset(
                        'assets/toffle_user.webp',
                        width: 96,
                        height: 96,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildDefaultAvatar();
                        },
                      ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _nickname,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _navigateToEditor,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD272FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.edit,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RobChatPage(),
                  ),
                );
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.asset(
                    'assets/mine_rob.webp',
                    width: 105,
                    height: 110,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 105,
                        height: 110,
                        color: Colors.grey.withOpacity(0.3),
                        child: const Icon(Icons.smart_toy, size: 48),
                      );
                    },
                  ),
                  IntrinsicWidth(
                    child: Container(
                      height: 31,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.5),
                        border: Border.all(
                          color: const Color(0xFFF477FF),
                          width: 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'AI Assistant',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFF477FF),
                        ),
                      ),
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

  Widget _buildListSection() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildListItem(
            title: 'Wallet',
            iconPath: 'assets/wallet_green_icon.webp',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WalletDetailPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildListItem(
            title: 'Privacy Policy',
            iconPath: 'assets/icon_me_privacy_policy.webp',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildListItem(
            title: 'User Agreement',
            iconPath: 'assets/icon_me_user_agreement.webp',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserAgreementPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildListItem(
            title: 'About us',
            iconPath: 'assets/icon_me_about us.webp',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutUsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListItem({
    required String title,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF333333).withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFD272FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Image.asset(
              iconPath,
              width: 48,
              height: 48,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 48,
                  height: 48,
                  color: Colors.grey.withOpacity(0.3),
                  child: const Icon(Icons.image, size: 24),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      width: 96,
      height: 96,
      color: Colors.grey.withOpacity(0.3),
      child: const Icon(Icons.person, size: 48),
    );
  }
}

