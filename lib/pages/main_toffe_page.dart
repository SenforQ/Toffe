import 'package:flutter/material.dart';
import '../pages/home_toffe_page.dart';
import '../pages/dynamic_toffe_page.dart';
import '../pages/post_toffe_page.dart';
import '../pages/me_toffe_page.dart';
import '../widgets/custom_tabbar.dart';

class MainToffePage extends StatefulWidget {
  const MainToffePage({super.key});

  @override
  State<MainToffePage> createState() => _MainToffePageState();
}

class _MainToffePageState extends State<MainToffePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeToffePage(),
    const DynamicToffePage(),
    const PostToffePage(),
    const MeToffePage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_currentIndex],
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomTabBar(
              currentIndex: _currentIndex,
              onTap: _onTabTapped,
            ),
          ),
        ],
      ),
    );
  }
}

