import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'evaluations_screen/evaluations_screen.dart';
import 'home_screen/home_screen.dart';
import 'widgets/bottom_nav_btn/bottom_nav_btn.dart';
import 'widgets/bottom_nav_btn/clipper.dart';
import 'widgets/bottom_nav_btn/constants.dart';
import 'menu_screen/menu_screen.dart';
import 'profile_screen/profile_screen.dart';
import 'time_screen/time_screen.dart';


List<Widget> screens = [
  HomeScreen(),
  ScheduleScreen(),
  MenuScreen(),
  GradesScreen(),
  ProfileScreen(),
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  void animateToPage(int page) {
    setState(() {
      _currentIndex = page; // Обновляем текущий индекс
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Используем AnimatedSwitcher для анимации переходов
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300), // Длительность анимации
          child: screens[_currentIndex], // Отображаем текущий экран
          transitionBuilder: (Widget child, Animation<double> animation) {
            // Используем FadeTransition для анимации
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: bottomNav(context),
        ),
      ],
    );
  }

  Widget bottomNav(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonHeight = screenWidth * 0.18; // Высота нижней навигации (18% от ширины)
    double paddingHorizontal = screenWidth * 0.045; // Отступы (4.5% от ширины)
    double iconSize = screenWidth * 0.08; // Размер иконок (8% от ширины)

    return Padding(
      padding: EdgeInsets.fromLTRB(paddingHorizontal, 0, paddingHorizontal, 40),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        color: Colors.transparent,
        elevation: 6,
        child: Container(
          height: buttonHeight,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                left: screenWidth * 0.03, // Отступ слева (3%)
                right: screenWidth * 0.03, // Отступ справа (3%)
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BottomNavBTN(
                      onPressed: animateToPage,
                      icon: IconlyLight.home,
                      currentIndex: _currentIndex,
                      index: 0,
                    ),
                    BottomNavBTN(
                      onPressed: animateToPage,
                      icon: IconlyLight.time_circle,
                      currentIndex: _currentIndex,
                      index: 1,
                    ),
                    BottomNavBTN(
                      onPressed: animateToPage,
                      icon: IconlyLight.category,
                      currentIndex: _currentIndex,
                      index: 2,
                    ),
                    BottomNavBTN(
                      onPressed: animateToPage,
                      icon: IconlyLight.document,
                      currentIndex: _currentIndex,
                      index: 3,
                    ),
                    BottomNavBTN(
                      onPressed: animateToPage,
                      icon: IconlyLight.profile,
                      currentIndex: _currentIndex,
                      index: 4,
                    ),
                  ],
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.decelerate,
                top: 0,
                left: animatedPositionedLeftValue(context, _currentIndex), // Передаем ширину экрана
                child: Column(
                  children: [
                    Container(
                      height: screenWidth * 0.01, // Высота индикатора (1% от ширины)
                      width: screenWidth * 0.12, // Ширина индикатора (12% от ширины)
                      decoration: BoxDecoration(
                        color: const Color(0xFF00796B),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    ClipPath(
                      clipper: MyCustomClipper(),
                      child: Container(
                        height: buttonHeight * 0.83, // Высота клипированного контейнера
                        width: screenWidth * 0.12, // Ширина клипированного контейнера
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors:
                                gradient, // Предполагается, что переменная gradient уже определена где-то в коде
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


