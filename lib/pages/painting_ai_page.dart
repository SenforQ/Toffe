import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class PaintingAiPage extends StatefulWidget {
  final String? initialPrompt;

  const PaintingAiPage({super.key, this.initialPrompt});

  @override
  State<PaintingAiPage> createState() => _PaintingAiPageState();
}

class _PaintingAiPageState extends State<PaintingAiPage> {
  final TextEditingController _promptController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? _generatedImageUrl;
  bool _isLoading = false;
  String? _errorMessage;
  final Random _random = Random();
  String? _lastPrompt;

  static const String _apiKey = 'e44f1c8d3b4348c8af5012ebc633e5a7.o9BlItUPELtlKrms';
  static const String _apiUrl = 'https://open.bigmodel.cn/api/paas/v4/images/generations';

  static const List<String> _tattooPrompts = [
    'A detailed black and gray realism tattoo for the upper arm, featuring a majestic dragon with intricate scales. Traditional Japanese style with fine line work and subtle shading techniques.',
    'A vibrant watercolor tattoo for the forearm, depicting a blooming cherry blossom tree with soft pink petals. Fluid color transitions and artistic brushstroke effects for a dreamy appearance.',
    'An intricate geometric mandala tattoo for the back, featuring symmetrical patterns and sacred geometry. Fine line work, dotwork techniques, and precise geometric shapes creating a spiritual effect.',
    'A bold traditional American tattoo for the calf, featuring a classic anchor with rope details. Bold black outlines, vibrant red and blue colors, and traditional shading for a timeless look.',
    'A delicate minimalist tattoo for the wrist, featuring a simple line art bird in flight. Clean, thin lines and negative space creating an elegant and understated piece.',
    'A detailed portrait tattoo for the thigh, featuring a realistic wolf with piercing eyes and detailed fur texture. Photorealistic shading and natural color tones for a lifelike appearance.',
    'An abstract tribal tattoo for the shoulder, featuring bold black patterns and flowing lines. Traditional tribal motifs with modern abstract elements creating a powerful visual statement.',
    'A colorful neo-traditional tattoo for the bicep, featuring a vibrant rose with thorns and leaves. Rich colors, bold outlines, and detailed shading creating depth in modern style.',
    'A detailed biomechanical tattoo for the forearm, featuring mechanical gears blending with organic elements. Intricate line work, metallic textures, and fusion of organic and mechanical aesthetics.',
    'A nature-inspired tattoo for the side rib area, featuring a forest scene with trees and mountains. Realistic shading, natural color palettes, and detailed line work for a scenic piece.',
    'A Japanese irezumi style tattoo for the full sleeve, featuring koi fish swimming through waves. Traditional Japanese elements, bold colors, and flowing water patterns.',
    'A minimalist geometric tattoo for the ankle, featuring simple geometric shapes and clean lines. Negative space effectively used to create a modern, abstract pattern.',
    'A detailed blackwork tattoo for the chest, featuring intricate patterns and mandala-inspired elements. Solid black ink, precise line work, and symmetrical patterns for a bold piece.',
    'A realistic animal portrait tattoo for the forearm, featuring a majestic lion with a detailed mane. Photorealistic techniques, natural fur texture, and lifelike shading for a regal appearance.',
    'A floral tattoo for the shoulder blade, featuring a bouquet of roses and peonies. Soft color gradients, detailed petal work, and natural shading for a romantic and elegant piece.',
    'An abstract geometric tattoo for the collarbone area, featuring flowing lines and geometric shapes. Clean lines and strategic negative space creating movement and balance.',
    'A traditional sailor tattoo for the upper arm, featuring a ship sailing through stormy seas. Bold black outlines, classic shading, and nautical elements for a timeless maritime piece.',
    'A detailed dotwork tattoo for the back, featuring a sacred geometry pattern with intricate dotwork shading. Precise dot placement, symmetrical patterns, and spiritual symbols.',
    'A realistic portrait tattoo for the thigh, featuring a detailed face with expressive eyes. Photorealistic techniques, natural skin tones, and lifelike shading for a stunning portrait.',
    'A colorful abstract tattoo for the forearm, featuring flowing colors and organic shapes. Vibrant color gradients, fluid lines, and artistic brushstroke effects for a dynamic piece.',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialPrompt != null && widget.initialPrompt!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _promptController.text = widget.initialPrompt!;
        _generateImage();
      });
    }
  }

  @override
  void dispose() {
    _promptController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _insertRandomPrompt() {
    final prompt = _tattooPrompts[_random.nextInt(_tattooPrompts.length)];
    setState(() {
      _promptController.text = prompt;
    });
  }

  Future<void> _pasteFromClipboard() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    if (clipboardData != null && clipboardData.text != null) {
      setState(() {
        _promptController.text = clipboardData.text!;
      });
    }
  }

  Future<void> _generateImage() async {
    final prompt = _promptController.text.trim();
    if (prompt.isEmpty || _isLoading) return;

    setState(() {
      _isLoading = true;
      _generatedImageUrl = null;
      _errorMessage = null;
      _lastPrompt = prompt;
    });

    try {
      final response = await _callZhipuAIImageGeneration(prompt);
      setState(() {
        _generatedImageUrl = response;
        _isLoading = false;
      });
      _promptController.clear();
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to generate image. Please try again.';
        _isLoading = false;
      });
    }
  }

  Future<void> _regenerateImage() async {
    if (_lastPrompt == null || _lastPrompt!.isEmpty || _isLoading) return;

    setState(() {
      _isLoading = true;
      _generatedImageUrl = null;
      _errorMessage = null;
    });

    try {
      final response = await _callZhipuAIImageGeneration(_lastPrompt!);
      setState(() {
        _generatedImageUrl = response;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to regenerate image. Please try again.';
        _isLoading = false;
      });
    }
  }

  Future<void> _saveImage() async {
    if (_generatedImageUrl == null) return;

    try {
      Uint8List imageBytes;
      
      if (_generatedImageUrl!.startsWith('data:image')) {
        // Base64 image
        final base64String = _generatedImageUrl!.split(',')[1];
        imageBytes = base64Decode(base64String);
      } else {
        // Network image
        final response = await http.get(Uri.parse(_generatedImageUrl!));
        if (response.statusCode != 200) {
          throw Exception('Failed to download image');
        }
        imageBytes = response.bodyBytes;
      }

      // Save to temporary file first
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/tattoo_${DateTime.now().millisecondsSinceEpoch}.png');
      await tempFile.writeAsBytes(imageBytes);

      // Save to gallery
      final result = await ImageGallerySaver.saveFile(
        tempFile.path,
        name: 'tattoo_${DateTime.now().millisecondsSinceEpoch}',
      );

      // Clean up temp file
      if (await tempFile.exists()) {
        await tempFile.delete();
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image saved to gallery successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save image: $e'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<String> _callZhipuAIImageGeneration(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'cogview-3-flash',
          'prompt': prompt,
          'size': '1024x1024',
          'n': 1,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        // Try different response formats
        if (data['data'] != null && data['data'].isNotEmpty) {
          final imageData = data['data'][0];
          if (imageData['url'] != null) {
            return imageData['url'];
          }
          if (imageData['b64_json'] != null) {
            return 'data:image/png;base64,${imageData['b64_json']}';
          }
        }
        
        // Alternative response format
        if (data['image_url'] != null) {
          return data['image_url'];
        }
        
        if (data['image'] != null) {
          return data['image'];
        }
        
        throw Exception('No image data in response: ${response.body}');
      } else {
        final errorBody = response.body;
        try {
          final errorData = jsonDecode(errorBody);
          throw Exception(errorData['error']?['message'] ?? 'API request failed: ${response.statusCode}');
        } catch (e) {
          throw Exception('API request failed: ${response.statusCode} - $errorBody');
        }
      }
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Network error: $e');
    }
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
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'AI Painting',
          style: TextStyle(color: Colors.white),
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
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: statusBarHeight),
                      if (_generatedImageUrl != null)
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: _generatedImageUrl!.startsWith('data:image')
                                    ? Image.memory(
                                        base64Decode(_generatedImageUrl!.split(',')[1]),
                                        fit: BoxFit.contain,
                                      )
                                    : Image.network(
                                        _generatedImageUrl!,
                                        fit: BoxFit.contain,
                                        loadingBuilder: (context, child, loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return Container(
                                            height: 400,
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD272FF)),
                                              ),
                                            ),
                                          );
                                        },
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            height: 400,
                                            color: Colors.grey[300],
                                            child: const Center(
                                              child: Icon(
                                                Icons.error,
                                                size: 48,
                                                color: Colors.red,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 28,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: _regenerateImage,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.refresh,
                                                size: 16,
                                                color: Colors.black,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                'Regenerate',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      GestureDetector(
                                        onTap: _saveImage,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.save,
                                                size: 16,
                                                color: Colors.black,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                'Save',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (_isLoading)
                        Container(
                          height: 400,
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD272FF)),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Generating image...',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (_errorMessage != null)
                        Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.red, width: 1),
                          ),
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              _buildInputArea(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _promptController,
              decoration: const InputDecoration(
                hintText: 'Eg: Generate An Image Of A Banana Wearing A Costume.',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              ),
              style: const TextStyle(color: Colors.black),
              maxLines: null,
              textInputAction: TextInputAction.newline,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: _insertRandomPrompt,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Random Prompt',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.swap_horiz,
                              color: Colors.black,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: _pasteFromClipboard,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.add_box_outlined,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: _generateImage,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _isLoading
                        ? const Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                          )
                        : const Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                            size: 20,
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

