import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomTabBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const tabBarHeight = 83.0;

    return Container(
      width: screenWidth,
      height: tabBarHeight,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/img_tab_bg.webp',
              fit: BoxFit.fill,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: _buildTabItem(
                  index: 0,
                  normalImage: 'assets/btn_tab_challenge_pre.webp',
                  selectedImage: 'assets/btn_tab_challenge_nor.webp',
                  isSelected: currentIndex == 0,
                  onTap: () => onTap(0),
                ),
              ),
              Expanded(
                child: _buildTabItem(
                  index: 1,
                  normalImage: 'assets/btn_tab_dynamic_pre.webp',
                  selectedImage: 'assets/btn_tab_dynamic_nor.webp',
                  isSelected: currentIndex == 1,
                  onTap: () => onTap(1),
                ),
              ),
              Expanded(
                child: _buildTabItem(
                  index: 2,
                  normalImage: 'assets/btn_tab_post_pre.webp',
                  selectedImage: 'assets/btn_tab_post_nor.webp',
                  isSelected: currentIndex == 2,
                  onTap: () => onTap(2),
                ),
              ),
              Expanded(
                child: _buildTabItem(
                  index: 3,
                  normalImage: 'assets/btn_tab_me_pre.webp',
                  selectedImage: 'assets/btn_tab_me_nor.webp',
                  isSelected: currentIndex == 3,
                  onTap: () => onTap(3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({
    required int index,
    required String normalImage,
    required String selectedImage,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.center,
        child: Image.asset(
          isSelected ? selectedImage : normalImage,
          width: 40,
          height: 40,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 40,
              height: 40,
              color: Colors.grey.withOpacity(0.3),
              child: const Icon(Icons.image),
            );
          },
        ),
      ),
    );
  }
}

