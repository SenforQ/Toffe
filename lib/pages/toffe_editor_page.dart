import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToffeEditorPage extends StatefulWidget {
  const ToffeEditorPage({super.key});

  @override
  State<ToffeEditorPage> createState() => _ToffeEditorPageState();
}

class _ToffeEditorPageState extends State<ToffeEditorPage> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _signatureController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  String? _avatarPath;
  String? _relativeAvatarPath;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nicknameController.text = prefs.getString('user_nickname') ?? 'Toffe';
      _signatureController.text = prefs.getString('user_signature') ?? '';
      _relativeAvatarPath = prefs.getString('user_avatar_path');
      if (_relativeAvatarPath != null) {
        _loadAvatarFromPath(_relativeAvatarPath!);
      }
    });
  }

  Future<void> _loadAvatarFromPath(String relativePath) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final fullPath = '${appDir.path}/$relativePath';
      if (await File(fullPath).exists()) {
        setState(() {
          _avatarPath = fullPath;
        });
      }
    } catch (e) {
      print('Error loading avatar: $e');
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _avatarPath = image.path;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('选择图片失败: $e')),
        );
      }
    }
  }

  Future<String> _saveImageToSandbox(String imagePath) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final imagesDir = Directory('${appDir.path}/user_images');
      if (!await imagesDir.exists()) {
        await imagesDir.create(recursive: true);
      }

      final fileName = 'avatar_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedPath = '${imagesDir.path}/$fileName';
      final relativePath = 'user_images/$fileName';

      final sourceFile = File(imagePath);
      await sourceFile.copy(savedPath);

      return relativePath;
    } catch (e) {
      throw Exception('保存图片失败: $e');
    }
  }

  Future<void> _saveUserData() async {
    if (_nicknameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('昵称不能为空')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      
      String? savedRelativePath = _relativeAvatarPath;
      
      if (_avatarPath != null && !_avatarPath!.contains('user_images')) {
        savedRelativePath = await _saveImageToSandbox(_avatarPath!);
      }

      await prefs.setString('user_nickname', _nicknameController.text.trim());
      await prefs.setString('user_signature', _signatureController.text.trim());
      if (savedRelativePath != null) {
        await prefs.setString('user_avatar_path', savedRelativePath);
      }

      if (mounted) {
        Navigator.of(context).pop({
          'nickname': _nicknameController.text.trim(),
          'signature': _signatureController.text.trim(),
          'avatarPath': savedRelativePath,
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('保存失败: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _signatureController.dispose();
    super.dispose();
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
          'Edit Profile',
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
        leading: _buildBackButton(context),
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/base_content_bg.webp'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                SizedBox(height: statusBarHeight + 20),
                _buildAvatarSection(),
                const SizedBox(height: 40),
                _buildNicknameSection(),
                const SizedBox(height: 24),
                _buildSignatureSection(),
                const SizedBox(height: 40),
                _buildSaveButton(),
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

  Widget _buildAvatarSection() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipOval(
          child: _avatarPath != null
              ? Image.file(
                  File(_avatarPath!),
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildDefaultAvatar();
                  },
                )
              : _buildDefaultAvatar(),
        ),
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      width: 120,
      height: 120,
      color: Colors.grey.withOpacity(0.3),
      child: const Icon(
        Icons.person,
        size: 60,
        color: Colors.white,
      ),
    );
  }

  Widget _buildNicknameSection() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nickname',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _nicknameController,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: 'Enter nickname',
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignatureSection() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Signature',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _signatureController,
            maxLines: 3,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintText: 'Enter signature',
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFD272FF),
        borderRadius: BorderRadius.circular(25),
      ),
      child: _isLoading
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
          : GestureDetector(
              onTap: _saveUserData,
              child: const Text(
                'Save',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
    );
  }
}

