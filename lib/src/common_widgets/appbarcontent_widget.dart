import 'package:flutter/material.dart';
import 'package:vivid/src/constants/colors.dart';

class AppBarContentWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  AppBarContentWidget({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    // You can customize the app bar content based on the selected index
    switch (selectedIndex) {
      case 0:
        return _buildProfileContent();
      case 1:
        return _buildDiscoverContent();
      case 2:
        return _buildChatContent();
      default:
        return _buildDefaultContent();
    }
  }

  Widget _buildProfileContent() {
    // Customize this widget with the content for the Profile tab
    return Text(
        'Profile',
      style: TextStyle(
        fontFamily: 'SF PRO',
        letterSpacing: 1,
        fontWeight: FontWeight.bold,
          color: vivid_colors.ttHeadColor
      ),
    );
  }

  Widget _buildChatContent() {
    // Customize this widget with the content for the Chat tab
    return Text(
      'Chat',
      style: TextStyle(
          fontFamily: 'SF PRO',
          letterSpacing: 1,
          fontWeight: FontWeight.bold,
          color: vivid_colors.ttHeadColor
      ),
    );
  }

  Widget _buildDiscoverContent() {
    // Customize this widget with the content for the Discover tab
    return Text(
      'Discover',
      style: TextStyle(
          fontFamily: 'SF PRO',
          letterSpacing: 1,
          fontWeight: FontWeight.bold,
          color: vivid_colors.ttHeadColor
      ),
    );
  }

  Widget _buildDefaultContent() {
    // Customize this widget with the content for the default case
    return Text(
      'Area 51',
      style: TextStyle(
          fontFamily: 'SF PRO',
          letterSpacing: 1,
          fontWeight: FontWeight.bold,
          color: vivid_colors.ttHeadColor
      ),
    );
  }
}
