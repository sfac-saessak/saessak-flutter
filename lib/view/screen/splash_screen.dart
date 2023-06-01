import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  static const String route = '/splash';

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 4).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Scaffold(
            backgroundColor: Colors.white, // 초록색 배경
            body: Center(
              child: Stack(children: [
                Container(
                  width: Get.width,
                  height: Get.height,
                  child: CustomPaint(
                    painter: HolePainter(
                        color: Color(0xff8EC057),
                        holeSize: _scaleAnimation.value * 400),
                    child: Center(
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 310,
                  child: Opacity(
                    opacity: _opacityAnimation.value,
                    child: Center(
                      child: Image.asset(
                        'assets/images/title.png',
                      ),
                    ),
                  ),
                )
              ]),
            ));
      },
    );
  }
}

class HolePainter extends CustomPainter {
  HolePainter({
    required this.color,
    required this.holeSize,
  });

  Color color;
  double holeSize;

  @override
  void paint(Canvas canvas, Size size) {
    double radius = holeSize / 2;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    Rect outerCircleRect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: radius);

    Path transparentHole = Path.combine(
      PathOperation.difference,
      Path()..addRect(rect),
      Path()
        ..addOval(outerCircleRect)
        ..close(),
    );
    canvas.drawPath(transparentHole, Paint()..color = color);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
