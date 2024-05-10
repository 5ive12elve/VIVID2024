import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vivid/src/features/profile/screens/profile_screen.dart';
import 'package:vivid/src/features/authentication/screens/sign_in_screen/signin_screen.dart';
import 'package:vivid/src/routing/main_screen/screens/chat_screen/chat.dart';
import 'package:vivid/src/constants/colors.dart';
import '../../../../common_widgets/appbarcontent_widget.dart';
import '../../../../common_widgets/botnavbar_widget.dart';
import '../../../../features/authentication/repository/authentication_repository/auth_repo.dart';
import '../search_bar_screen/search_bar_screen.dart';

class mainScreen extends StatefulWidget {
  mainScreen({required Key key, required int initialPage}) : super(key: key);

  @override
  _MyMainScreenState createState() => _MyMainScreenState();
}

class _MyMainScreenState extends State<mainScreen> {
  int _selectedItem = 0;
  var _pages = [ProfileScreen(), SearchScreen(), Chat()];
  var _pageController = PageController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  // Define a custom text style with the 'LexendDeca' font family
  final TextStyle _customTextStyle = TextStyle(fontFamily: 'LexendDeca');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: vivid_colors.primaryColor,
      appBar: AppBar(
        title: AppBarContentWidget(
          selectedIndex: _selectedItem,
          onItemTapped: (index) {
            setState(() {
              _selectedItem = index;
              _pageController.animateToPage(
                _selectedItem,
                duration: Duration(milliseconds: 500),
                curve: Curves.linear,
              );
            });
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu_rounded, color: vivid_colors.ttHeadColor, size: 30,),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications, color: vivid_colors.ttHeadColor, size: 30,),
            onPressed: () {
              // Handle notification icon click
            },
          ),
        ],
      ),
      body: PageView(
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _selectedItem = index;
          });
        },
        controller: _pageController,
      ),
      bottomNavigationBar: BotNavBarWidget(
        selectedItem: _selectedItem,
        onItemTapped: (index) {
          setState(() {
            _selectedItem = index;
            _pageController.animateToPage(
              _selectedItem,
              duration: Duration(milliseconds: 500),
              curve: Curves.linear,
            );
          });
        },
      ),
      drawer: Drawer(
        backgroundColor: vivid_colors.primaryColor.withOpacity(0.8),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Profile", style: _customTextStyle),
              onTap: () {
                // Handle logout action
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout", style: _customTextStyle),
              onTap: () async {
                await AuthRepo.instance.logout();
                Get.off(()=>SigninScreen());
                // Handle logout action
              },
            ),
          ],
        ),
      ),
    );
  }
}
