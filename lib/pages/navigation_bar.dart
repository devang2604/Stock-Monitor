import 'package:crypto_api/constants.dart';
import 'package:crypto_api/pages/inside_pages/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation>
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

  int _currentIndex = 0;

  List<Widget> pages = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    double heightOne = MediaQuery.of(context).size.height;
    // double widthOne = MediaQuery.of(context).size.width;
    return SafeArea(
      child: FadeTransition(
        opacity: _animation,
        child: Scaffold(
          backgroundColor: kblack,
          body: pages.elementAt(_currentIndex),
          bottomNavigationBar: SnakeNavigationBar.color(
            currentIndex: _currentIndex,
            showSelectedLabels: false,
            selectedItemColor: kgreen,
            unselectedItemColor: Colors.grey,
            snakeViewColor: Colors.black,
            onTap: (index) => setState(() => _currentIndex = index),
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/icons/home1.png",
                  height: heightOne * 0.03,
                ),
                activeIcon: Image.asset(
                  "assets/icons/home2.png",
                  height: heightOne * 0.034,
                ),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/icons/explore1.png",
                  height: heightOne * 0.03,
                ),
                activeIcon: Image.asset(
                  "assets/icons/explore2.png",
                  height: heightOne * 0.034,
                ),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/icons/bell1.png",
                  height: heightOne * 0.03,
                ),
                activeIcon: Image.asset(
                  "assets/icons/bell2.png",
                  height: heightOne * 0.034,
                ),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/icons/profile1.png",
                  height: heightOne * 0.03,
                ),
                activeIcon: Image.asset(
                  "assets/icons/profile2.png",
                  height: heightOne * 0.034,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
