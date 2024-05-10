import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:vivid/src/constants/colors.dart';

class BotNavBarWidget extends StatelessWidget {
  final int selectedItem;
  final ValueChanged<int> onItemTapped;

  BotNavBarWidget({
    required this.selectedItem,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(0),
      child: CurvedNavigationBar(
        index: selectedItem,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.person, size: 30, color: vivid_colors.primaryColor,),
          Icon(Icons.search_rounded, size: 30, color: vivid_colors.primaryColor,),
          Icon(Icons.chat_bubble, size: 30, color: vivid_colors.primaryColor,),
        ],
        color: vivid_colors.ttSubtitleColor.withOpacity(0.8),
        buttonBackgroundColor: vivid_colors.ttSubtitleColor.withOpacity(0.5),
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        onTap: onItemTapped,
      ),
    );
  }
}
