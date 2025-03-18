import 'package:flutter/material.dart';


class BottomNavBTN extends StatelessWidget {
  final Function(int) onPressed;
  final IconData icon;
  final int index;
  final int currentIndex;

  const BottomNavBTN({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.index,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Получаем ширину экрана
    double screenWidth = MediaQuery.of(context).size.width;

    // Вычисляем размеры на основе ширины экрана
    double buttonHeight = screenWidth * 0.13; // 13% от ширины экрана
    double buttonWidth = screenWidth * 0.17; // 17% от ширины экрана
    double iconSize = screenWidth * 0.08; // 8% от ширины экрана
    double leftPosition = screenWidth * 0.04; // 4% от ширины экрана
    double bottomPosition = screenWidth * 0.015; // 1.5% от ширины экрана

    return InkWell(
      onTap: () {
        onPressed(index);
      },
      child: Container(
        height: buttonHeight,
        width: buttonWidth,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            (currentIndex == index)
                ? Positioned(
                    left: leftPosition,
                    bottom: bottomPosition,
                    child: Icon(
                      icon,
                      color: Colors.black,
                      size: iconSize,
                    ),
                  )
                : Container(),
            AnimatedOpacity(
              opacity: (currentIndex == index) ? 1 : 0.2,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              child: Icon(
                icon,
                color: Colors.green[100],
                size: iconSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
