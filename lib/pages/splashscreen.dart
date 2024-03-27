import 'package:crypto_api/constants.dart';
import 'package:crypto_api/pages/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_icon/animated_icon.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut.flipped,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double heightOne = MediaQuery.of(context).size.height;
    double widthOne = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: FadeTransition(
          opacity: _animation,
          child: SizedBox(
            height: heightOne,
            width: widthOne,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Lottie.asset(
                  'assets/lottie/anim1.json',
                  height: 300,
                ),
                const Text(
                  "A New Revolution",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "Discover the future of finance with IO Crypto -",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      "explore, learn, and embrace",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      "the World of Cryptocurrency.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: widthOne * 0.14,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Navigation(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: kgreen,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: widthOne * 0.05,
                            vertical: heightOne * 0.013),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'CREATE YOU PROFILE  ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: kblack,
                              ),
                            ),
                            AnimateIcon(
                              key: UniqueKey(),
                              onTap: () {},
                              color: kblack,
                              iconType: IconType.continueAnimation,
                              height: 25,
                              width: 25,
                              animateIcon: AnimateIcons.circlesMenu3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
