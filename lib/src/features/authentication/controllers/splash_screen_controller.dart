import 'package:flutter/material.dart';
import 'package:vivid/src/constants/film_industry_words.dart';
import 'package:vivid/src/constants/colors.dart';
import '../screens/sign_up_screen/signup_screen.dart';


class SplashScreenController extends StatefulWidget {
  @override
  _SplashScreenControllerState createState() => _SplashScreenControllerState();
}

class _SplashScreenControllerState extends State<SplashScreenController>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _loadingAnimation;

  int currentIndex = 0;
  double loadingPercentage = 0.0;
  double rotation = 0.0;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    // Initialize loading animation
    _loadingAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          loadingPercentage = _loadingAnimation.value;
        });
      });

    // Start loading animation
    _controller.forward();

    // Start changing text
    _startChangingText();
  }

  void _startChangingText() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          currentIndex = (currentIndex + 1) % filmIndustryWords.length;
        });

        if (loadingPercentage == 1.0) {
          // Wait for 3 seconds before navigating to GreetingsScreen
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => SignupScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;
                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);
                  return SlideTransition(position: offsetAnimation, child: child);
                },
              ),
            );
          });
        } else {
          _startChangingText();
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Hero(
          tag: 'vivid_text_hero',
          child: GlowingText(
            text: loadingPercentage == 1.0 ? "VIVID" : filmIndustryWords[currentIndex],
            textStyle: TextStyle(
              fontSize: 22,
              letterSpacing: 7.0,
              fontWeight: FontWeight.w100,
              fontFamily: 'LexendDeca',
              color: vivid_colors.ttSecondaryColor,
            ),
            glowColor: vivid_colors.ttSecondaryColor,
            glowRadius: 40.0 * loadingPercentage,
            rotation: rotation, // Pass the rotation value
          ),
        ),
        SizedBox(height: 23),
        CircularProgressIndicator(
          value: loadingPercentage,
          valueColor: AlwaysStoppedAnimation<Color>(vivid_colors.ttSecondaryColor),
          strokeWidth: 15.0,
        ),
      ],
    );
  }
}

class GlowingText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Color glowColor;
  final double glowRadius;
  final double rotation;

  GlowingText({
    required this.text,
    required this.textStyle,
    required this.glowColor,
    required this.glowRadius,
    required this.rotation,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect bounds) {
        return RadialGradient(
          center: Alignment.center,
          radius: glowRadius,
          colors: [glowColor.withOpacity(1.0), vivid_colors.ttSecondaryColor],
          stops: [0.0, 1.0],
        ).createShader(bounds);
      },
      child: Transform.rotate(
        angle: rotation, // Apply rotation
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
