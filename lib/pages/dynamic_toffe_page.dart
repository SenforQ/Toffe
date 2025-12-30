import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'rob_chat_page.dart';
import 'painting_ai_page.dart';

class DynamicToffePage extends StatefulWidget {
  const DynamicToffePage({super.key});

  @override
  State<DynamicToffePage> createState() => _DynamicToffePageState();
}

class _DynamicToffePageState extends State<DynamicToffePage> {
  String? _q1Answer;
  String? _q2Answer;
  final TextEditingController _q3Controller = TextEditingController();

  @override
  void dispose() {
    _q3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            width: screenWidth,
            child: Image.asset(
              'assets/img_ai_bg.webp',
              width: screenWidth,
              fit: BoxFit.fitWidth,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: screenWidth,
                  height: 200,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 48,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
          Container(
            width: screenWidth,
            height: screenHeight,
            color: Colors.transparent,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 81),
                  Center(
                    child: Image.asset(
                      'assets/img_ai.webp',
                      width: 295,
                      height: 284,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 295,
                          height: 284,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 48,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildQuestion1(),
                  const SizedBox(height: 32),
                  _buildQuestion2(),
                  const SizedBox(height: 32),
                  _buildQuestion3(),
                  const SizedBox(height: 40),
                  _buildSubmitButton(),
                  const SizedBox(height: 40),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Q1: Is this your first tattoo, or are you adding to your collection?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildOptionButton(
                text: 'First tattoo',
                isSelected: _q1Answer == 'First tattoo',
                onTap: () {
                  setState(() {
                    _q1Answer = 'First tattoo';
                  });
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildOptionButton(
                text: 'Adding more',
                isSelected: _q1Answer == 'Adding more',
                onTap: () {
                  setState(() {
                    _q1Answer = 'Adding more';
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuestion2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Q2: Pick a vibe: Bold & Classic, Delicate & Fine, or Abstract & Artistic?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildOptionButton(
                text: 'Bold & Classic',
                isSelected: _q2Answer == 'Bold & Classic',
                onTap: () {
                  setState(() {
                    _q2Answer = 'Bold & Classic';
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildOptionButton(
                text: 'Delicate & Fine',
                isSelected: _q2Answer == 'Delicate & Fine',
                onTap: () {
                  setState(() {
                    _q2Answer = 'Delicate & Fine';
                  });
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildOptionButton(
                text: 'Abstract & Artistic',
                isSelected: _q2Answer == 'Abstract & Artistic',
                onTap: () {
                  setState(() {
                    _q2Answer = 'Abstract & Artistic';
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuestion3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Q3: Want to include any personal symbols? (Initials, dates, nature elements, animals...)',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF4C1D95).withOpacity(0.6),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: TextField(
            controller: _q3Controller,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Yes, like: [animal, flower, date...]',
              hintStyle: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
              border: InputBorder.none,
            ),
            maxLines: 3,
          ),
        ),
      ],
    );
  }

  Widget _buildOptionButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFFF477FF), Color(0xFFD272FF)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: isSelected
              ? null
              : const Color(0xFF4C1D95).withOpacity(0.6),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: GestureDetector(
        onTap: () {
          if (_q1Answer != null && _q2Answer != null) {
            _showChoiceDialog();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please answer Q1 and Q2'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFF477FF), Color(0xFFD272FF)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'No problem! Submit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _buildDescription() {
    final buffer = StringBuffer();
    buffer.writeln('Q1: ${_q1Answer ?? "Not answered"}');
    buffer.writeln('Q2: ${_q2Answer ?? "Not answered"}');
    if (_q3Controller.text.trim().isNotEmpty) {
      buffer.writeln('Q3: ${_q3Controller.text.trim()}');
    }
    return buffer.toString();
  }

  String _buildPromptForImage() {
    final buffer = StringBuffer();
    buffer.write('Create a tattoo design. ');
    if (_q1Answer != null) {
      buffer.write('This is ${_q1Answer!.toLowerCase()}. ');
    }
    if (_q2Answer != null) {
      buffer.write('Style: ${_q2Answer}. ');
    }
    if (_q3Controller.text.trim().isNotEmpty) {
      buffer.write('Include personal symbols: ${_q3Controller.text.trim()}. ');
    }
    buffer.write('Create a detailed, professional tattoo design with appropriate placement, colors, and artistic style.');
    return buffer.toString();
  }

  String _buildMessageForChat() {
    final buffer = StringBuffer();
    buffer.write('Based on my preferences: ');
    if (_q1Answer != null) {
      buffer.write('This is ${_q1Answer!.toLowerCase()}. ');
    }
    if (_q2Answer != null) {
      buffer.write('I prefer ${_q2Answer}. ');
    }
    if (_q3Controller.text.trim().isNotEmpty) {
      buffer.write('I want to include: ${_q3Controller.text.trim()}. ');
    }
    buffer.write('Please provide personalized tattoo suggestions and advice.');
    return buffer.toString();
  }

  void _clearAllData() {
    setState(() {
      _q1Answer = null;
      _q2Answer = null;
      _q3Controller.clear();
    });
  }

  void _showChoiceDialog() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(
          'Choose an option',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              final prompt = _buildPromptForImage();
              _clearAllData();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaintingAiPage(
                    initialPrompt: prompt,
                  ),
                ),
              );
            },
            child: const Text('Generate Image'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              final message = _buildMessageForChat();
              _clearAllData();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RobChatPage(
                    initialMessage: message,
                  ),
                ),
              );
            },
            child: const Text('Get Suggestions'),
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
}

