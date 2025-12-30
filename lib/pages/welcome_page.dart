import 'package:flutter/material.dart';
import 'user_agreement_page.dart';
import 'privacy_policy_page.dart';
import 'main_toffe_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool _hasAgreed = false;

  Future<void> _agreeAndEnter() async {
    if (!_hasAgreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please read and agree to the terms'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MainToffePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/welcome_toffe_bg.webp',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 64,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: bottomPadding + 48,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _agreeAndEnter,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD272FF),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Enter App',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _hasAgreed = !_hasAgreed;
                        });
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        margin: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                          color: _hasAgreed
                              ? const Color(0xFFD272FF)
                              : Colors.transparent,
                          border: Border.all(
                            color: _hasAgreed
                                ? const Color(0xFFD272FF)
                                : Colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: _hasAgreed
                            ? const Icon(
                                Icons.check,
                                size: 14,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            height: 1.4,
                          ),
                          children: [
                            const TextSpan(text: 'I have read and agree '),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const UserAgreementPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Terms of Service',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const TextSpan(text: ' and '),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const PrivacyPolicyPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Privacy Policy',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white,
                                  ),
                                ),
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
          ),
        ],
      ),
    );
  }
}

