import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class RobChatPage extends StatefulWidget {
  final String? initialMessage;

  const RobChatPage({super.key, this.initialMessage});

  @override
  State<RobChatPage> createState() => _RobChatPageState();
}

class _RobChatPageState extends State<RobChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  final Random _random = Random();

  static const List<String> _presetQuestions = [
    'Does getting a tattoo hurt? How much pain should I expect?',
    'What are the side effects and risks of getting a tattoo?',
    'How long does it take for a tattoo to heal completely?',
    'What should I do to take care of my new tattoo?',
    'Can I get a tattoo if I have sensitive skin or allergies?',
    'How much does a tattoo typically cost?',
    'What tattoo style would suit me best?',
    'Is it safe to get a tattoo while pregnant or breastfeeding?',
    'How do I choose the right tattoo artist?',
    'Can tattoos be removed? What are the removal options?',
    'What is the difference between different tattoo styles like traditional, realism, and watercolor?',
    'How do I know if a tattoo shop is clean and safe?',
    'What should I avoid before getting a tattoo?',
    'Can I exercise or go swimming after getting a tattoo?',
    'How do I prevent tattoo infection?',
    'What does tattoo fading look like over time?',
    'Is it normal for a tattoo to scab and peel?',
    'Can I get a tattoo over scars or stretch marks?',
    'What are the best body placements for different tattoo designs?',
    'How do I prepare for my first tattoo appointment?',
  ];

  static const String _apiKey = 'e44f1c8d3b4348c8af5012ebc633e5a7.o9BlItUPELtlKrms';
  static const String _apiUrl = 'https://open.bigmodel.cn/api/paas/v4/chat/completions';

  @override
  void initState() {
    super.initState();
    _addWelcomeMessage();
    if (widget.initialMessage != null && widget.initialMessage!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _messageController.text = widget.initialMessage!;
        _sendMessage();
      });
    }
  }

  void _addWelcomeMessage() {
    setState(() {
      _messages.add(ChatMessage(
        text: "Hello! I'm your AI tattoo assistant. I'm here to help you explore the world of tattoos, from design ideas to aftercare tips. Whether you're thinking about your first tattoo or adding to your collection, I can provide guidance on styles, placement, meanings, and more. What would you like to know about tattoos today?",
        isUser: false,
        timestamp: DateTime.now(),
      ));
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _isLoading) return;

    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      _messageController.clear();
      _isLoading = true;
    });

    _scrollToBottom();

    try {
      final response = await _callZhipuAI(text);
      setState(() {
        _messages.add(ChatMessage(
          text: response,
          isUser: false,
          timestamp: DateTime.now(),
        ));
        _isLoading = false;
      });
      _scrollToBottom();
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(
          text: 'Sorry, I encountered an error. Please try again.',
          isUser: false,
          timestamp: DateTime.now(),
        ));
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  Future<String> _callZhipuAI(String userMessage) async {
    final messages = _messages
        .where((msg) => msg.isUser)
        .map((msg) => {'role': 'user', 'content': msg.text})
        .toList();
    messages.add({'role': 'user', 'content': userMessage});

    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': 'glm-4-flash',
        'messages': [
          {
            'role': 'system',
            'content':
                'You are a friendly and knowledgeable AI tattoo assistant. You help people who are interested in tattoos by providing advice on tattoo designs, styles, placement, meanings, aftercare, and answering questions about tattoo culture. Always respond in English and be helpful, informative, and encouraging.',
          },
          ...messages,
        ],
        'temperature': 0.7,
        'max_tokens': 1000,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'] ?? 'No response';
    } else {
      throw Exception('API request failed: ${response.statusCode}');
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _insertPresetQuestion() {
    final question = _presetQuestions[_random.nextInt(_presetQuestions.length)];
    setState(() {
      _messageController.text = question;
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
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
          'AI Assistant',
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
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length + (_isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == _messages.length) {
                        return _buildLoadingIndicator();
                      }
                      return _buildMessageBubble(_messages[index]);
                    },
                  ),
                ),
                _buildInputArea(),
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

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFD272FF).withOpacity(0.2),
              ),
              child: Image.asset(
                'assets/mine_rob.webp',
                width: 40,
                height: 40,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.smart_toy,
                    size: 24,
                    color: Color(0xFFD272FF),
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isUser
                    ? const Color(0xFFD272FF)
                    : Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(message.isUser ? 20 : 4),
                  bottomRight: Radius.circular(message.isUser ? 4 : 20),
                ),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  fontSize: 16,
                  color: message.isUser ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 8),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.3),
              ),
              child: const Icon(
                Icons.person,
                size: 24,
                color: Colors.white,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFD272FF).withOpacity(0.2),
            ),
            child: Image.asset(
              'assets/mine_rob.webp',
              width: 40,
              height: 40,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.smart_toy,
                  size: 24,
                  color: Color(0xFFD272FF),
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD272FF)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Ask about tattoos...',
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.6),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                maxLines: null,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _insertPresetQuestion,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFD272FF),
                  width: 2,
                ),
              ),
              child: const Center(
                child: Text(
                  'AI',
                  style: TextStyle(
                    color: Color(0xFFD272FF),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send,
                color: Color(0xFFD272FF),
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

